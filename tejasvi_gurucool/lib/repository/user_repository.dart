import 'package:flutter/foundation.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  UserRepository({FirebaseAuth firebaseAuth, Firestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

  Future<User> signInWithCredentials({
    @required String email,
    @required String password,
  }) async {
    try {
      final firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final DocumentSnapshot doc =
          await _firestore.collection("users").document(firebaseUser.uid).get();

      final user = _extractUser(doc);
      if (user == null) throw new Exception("Invalid User");
      return user;
    } on Exception catch (e) {
      print(e);
      throw new Exception("Login Failed");
    }
  }

  User _extractUser(DocumentSnapshot userDoc) {
    try {
      final String firstName = userDoc.data['firstName'] ?? "";
      final String lastName = userDoc.data['lastName'] ?? "";
      final String middleName = userDoc.data['middleName'] ?? "";
      final String userEmail = userDoc.data['email'] ?? "";
      final String phoneNo = userDoc.data['phoneNo'] ?? "";
      final bool isMember = userDoc.data['isMember'] ?? false;
      final bool isAdmin = userDoc.data['isAdmin'] ?? false;
      final List<String> batches =
          new List<String>.from(userDoc.data['batches']) ?? <String>[];
      final Timestamp birthDate =
          userDoc.data['birthDate'] ?? new DateTime.now();
      final Timestamp createdOn =
          userDoc.data['createdOn'] ?? new DateTime.now();
      final Timestamp updatedOn =
          userDoc.data['updatedOn'] ?? new DateTime.now();

      return new User(
        id: userDoc.documentID,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        email: userEmail,
        birthDate: birthDate.toDate(),
        phoneNo: phoneNo,
        isMember: isMember,
        isAdmin: isAdmin,
        batches: batches,
        createdOn: createdOn.toDate(),
        updatedOn: updatedOn.toDate(),
      );
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> registerUser({
    @required String firstName,
    @required String lastName,
    @required String middleName,
    @required DateTime birthDate,
    @required String phoneNo,
    @required String email,
    @required String password,
    @required List<String> batches,
  }) async {
    try {
      final firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection("users").document(firebaseUser.uid).setData({
        'firstName': firstName,
        'lastName': lastName,
        'middleName': middleName,
        'phoneNo': phoneNo.toString(),
        'isMember': false,
        'isAdmin': false,
        'batches': batches,
        'birthDate': birthDate,
        'email' : email,
        'createdOn': new DateTime.now(),
        'updatedOn': new DateTime.now(),
      });

      return await signInWithCredentials(email: email, password: password);
    } on Exception catch (e) {
      print(e);
      throw new Exception("Registraion Failed. Please try again");
    }
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<List<User>> getAllUsers() async {
    final List<User> users = <User>[];
    try {
      final result = await _firestore.collection("users").getDocuments();
      final usersDocs = result.documents;
      for (int i = 0; i < usersDocs.length; ++i) {
        final user = _extractUser(usersDocs[i]);
        if (user != null) users.add(user);
      }
    } on Exception catch (e) {
      print(e);
    }
    return users;
  }

  Future<void> changeMemberStatus(final String userId, final bool value) async {
    try {
      await _firestore
          .collection("users")
          .document(userId)
          .updateData({"isMember": value});
    } on Exception catch (e) {
      print(e);
    }
  }
}
