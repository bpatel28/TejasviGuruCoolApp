import 'package:flutter/foundation.dart';
import 'package:tejasvi_gurucool/mock_data.dart';
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
      final String lastName = doc.data['firstName'];
      final String middleName = doc.data['firstName'];
      final String userEmail = firebaseUser.email;
      final String phoneNo = doc.data['phoneNo'];
      final bool isMember = doc.data['isMember'];
      final List<DocumentReference> batches = doc.data['batches'];
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
        batches: batches,
        createdOn: createdOn.toDate(),
        updatedOn: updatedOn.toDate(),
      );
    } on Exception catch (e) {
      throw new Exception("Login Failed");
    }
  }

  Future<User> registerUser(
      {@required String firstName,
      @required String lastName,
      @required String middleName,
      @required DateTime birthDate,
      @required int phoneNo,
      @required String email,
      @required String password,
      @required List<String> batches}) async {
    await Future.delayed(Duration(seconds: 1));
    return Mock.user;
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
