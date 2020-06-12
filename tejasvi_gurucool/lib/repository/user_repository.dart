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

      final String firstName = doc.data['firstName'];
      final String lastName = doc.data['lastName'];
      final String middleName = doc.data['middleName'];
      final String userEmail = firebaseUser.email;
      final String phoneNo = doc.data['phoneNo'];
      final bool isMember = doc.data['isMember'];
      final bool isAdmin = doc.data['isAdmin'];
      final List<String> batches = new List<String>.from(doc.data['batches']);
      final Timestamp birthDate = doc.data['birthDate'];
      final Timestamp createdOn = doc.data['createdOn'];
      final Timestamp updatedOn = doc.data['updatedOn'];

      return new User(
        id: firebaseUser.uid,
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
      throw new Exception("Login Failed");
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
        'isAdmin' : false,
        'batches': batches,
        'birthDate': birthDate,
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
}
