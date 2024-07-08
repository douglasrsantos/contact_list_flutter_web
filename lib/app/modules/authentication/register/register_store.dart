import 'dart:developer';

import 'package:challenge_uex/app/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

import 'package:challenge_uex/app/core/interfaces/interfaces.dart';

part 'register_store.g.dart';

// ignore: library_private_types_in_public_api
class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  final IUser userRepository;

  RegisterStoreBase({required this.userRepository});

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @observable
  String? infoErrorMessage;

  @computed
  bool get hasError => infoErrorMessage != null;

  @observable
  String? infoSuccessMessage;

  @computed
  bool get hasSuccess => infoSuccessMessage != null;

  @observable
  bool isLoading = false;

  @observable
  bool isObscureText = true;

  @observable
  bool isObscureTextConfirmPassword = true;

  UserModel user = UserModel();

  ///Fill in the fields to register a new user
  Future<void> fillUser() async {
    user.email = emailController.text.trim();
    user.name = nameController.text;
    user.password = passwordController.text.trim();
  }

  ///Save a new user
  Future<void> saveNewUser() async {
    infoErrorMessage = null;
    infoSuccessMessage = null;
    isLoading = true;

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (formKey.currentState!.validate() == false) {
      isLoading = false;
      infoErrorMessage = 'Você precisa preencher os campos indicados!';
      return;
    }

    await fillUser();

    try {
      await userRepository.createUser(user: user);

      infoSuccessMessage = 'Usuário cadastrado. Faça o Login!';
    } catch (e) {
      log(e.toString());
      infoErrorMessage = e.toString();
    }
    isLoading = false;
  }

  ///Toggles the obscureText property of the Password field
  @action
  void toggleObscureTextPassword() {
    isObscureText = !isObscureText;
  }

  ///Toggles the obscureText property of the Confirm Password field
  @action
  void toggleObscureTextConfirmPassword() {
    isObscureTextConfirmPassword = !isObscureTextConfirmPassword;
  }
}
