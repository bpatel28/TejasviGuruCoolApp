import 'package:flutter/foundation.dart';
import 'package:tejasvi_gurucool/mock_data.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';

class UserRepository {
  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return Mock.user;
  }

  Future<User> registerUser({
    @required String firstName,
    @required String lastName,
    @required String middleName,
    @required DateTime birthDate,
    @required int phoneNo,
    @required String username,
    @required String email,
    @required String password,
    @required List<int> batches
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return Mock.user;
  }
}
