import 'dart:developer';

import 'package:challenge_uex/app/core/error/error.dart';
import 'package:challenge_uex/app/core/database/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:challenge_uex/app/core/interfaces/interfaces.dart';
import 'package:challenge_uex/app/core/models/models.dart';
import 'package:challenge_uex/routes.dart';

part 'app_store.g.dart';

// ignore: library_private_types_in_public_api
class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  final HiveService hiveService;
  final IUser userRepository;

  AppStoreBase({
    required this.hiveService,
    required this.userRepository,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @observable
  String? infoErrorMessage;

  @computed
  bool get hasError => infoErrorMessage != null;

  @observable
  bool isLoading = false;

  @observable
  UserModel? _user;

  @computed
  UserModel? get user => _user;

  @computed
  bool get isLogged => _user != null;

  ///Checks if the user is still logged in and maintains the session
  @action
  Future<void> tryLoginWithUserEmail() async {
    final result = await hiveService.getUserEmail();

    if (result != null) {
      final email = result;
      final userResult = await userRepository.getUserByEmail(email: email);

      if (userResult != null) {
        _user = userResult;
        await hiveService.saveUserEmail(email);
        routes.go('/home');
      }
    }
  }

  ///Login
  @action
  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      await userRepository.login(email: email, password: password);

      final userResult = await userRepository.getUserByEmail(email: email);
      if (userResult != null) {
        _user = userResult;
        await hiveService.saveUserEmail(email);
      }
    } catch (e) {
      log(e.toString());
      if (e == RequestError.notFound) {
        throw 'Usuário não cadastrado.';
      } else if (e == RequestError.unauthorized) {
        throw 'Senha Inválida.';
      }
      rethrow;
    }
  }

  ///Logout
  @action
  Future<void> logout() async {
    _user = null;
    await hiveService.clearUserEmail();
  }

  ///Synchronizes logged in user data
  @action
  Future<void> syncUser() async {
    final result = await hiveService.getUserEmail();

    if (result != null) {
      final email = result;

      final userResult = await userRepository.getUserByEmail(email: email);

      if (userResult != null) {
        _user = userResult;
        await hiveService.saveUserEmail(email);
      }
    }
  }
}
