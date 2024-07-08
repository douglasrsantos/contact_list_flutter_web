import 'package:challenge_uex/app/core/models/models.dart';

abstract class IUser {
  ///Create new user
  Future<void> createUser({required UserModel user});

  ///Get all users
  Future<List<UserModel>?> getAllUsers(); //TODO: REMOVE

  ///Get user by email
  Future<UserModel?> getUserByEmail({required String email});

  ///Login
  Future<void> login({required String email, required String password});

  ///Logout
  Future<void> logout();

  ///Delete user account
  Future<void> deleteAccount({required String email, required String password});
}
