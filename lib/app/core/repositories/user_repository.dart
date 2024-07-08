import 'dart:developer';

import 'package:challenge_uex/app/core/error/error.dart';
import 'package:challenge_uex/app/core/interfaces/interfaces.dart';
import 'package:challenge_uex/app/core/models/models.dart';
import 'package:challenge_uex/app/core/database/database.dart';

class UserRepository implements IUser {
  final HiveService hiveService;

  UserRepository({required this.hiveService});

  @override
  Future<void> createUser({required UserModel user}) async {
    try {
      await hiveService.createUser(user: user);
    } catch (e) {
      log(e.toString());
      if (e == RequestError.unauthorized) {
        throw 'E-mail já cadastrado. Faça o login!';
      } else {
        throw 'Erro ao cadastrar novo usuário.';
      }
    }
  }

  @override
  Future<UserModel?> getUserByEmail({required String email}) async {
    try {
      final result = await hiveService.getUserByEmail(email: email);

      return UserModel.fromMap(result);
    } catch (e) {
      if (e != RequestError.notFound) {
        throw e.toString();
      }
    }
    return null;
  }

  @override
  Future<List<UserModel>?> getAllUsers() async {
    final result = await hiveService.getAllUsers();

    if (result != null) {
      final users = List.generate(
        result.length,
        (index) => UserModel.fromMap(result['users'][index]),
      );
      return users;
    }
    return null;
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final result = await hiveService.getUserByEmail(email: email);

      if (result.isEmpty) {
        throw RequestError.notFound;
      } else if (result['password'] != password) {
        throw RequestError.unauthorized;
      }
    } catch (e) {
      log('UserRepository: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await hiveService.clearUserEmail();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount(
      {required String email, required String password}) async {
    try {
      await hiveService.deleteAccount(email: email, password: password);
    } catch (e) {
      log(e.toString());
      if (e == RequestError.unauthorized) {
        throw 'Senha Incorreta. O usuário não foi excluído';
      } else {
        rethrow;
      }
    }
  }
}
