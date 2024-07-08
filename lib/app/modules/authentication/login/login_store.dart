import 'package:challenge_uex/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

import 'package:challenge_uex/app_store.dart';

part 'login_store.g.dart';

// ignore: library_private_types_in_public_api
class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final AppStoreBase app;

  LoginStoreBase({required this.app});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  void init() async {
    await app.tryLoginWithUserEmail();

    if (app.isLogged) {
      routes.go('/home');
    }
  }

  Future<void> login() async {
    isLoading = true;
    infoErrorMessage = null;
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (formKey.currentState!.validate() == false) {
      isLoading = false;
      infoErrorMessage = 'Você precisa preencher os campos indicados!';
      return;
    }

    try {
      await app.login(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      infoErrorMessage = e.toString();
    }

    isLoading = false;
  }

  @action
  void toggleObscureTextPassword() {
    isObscureText = !isObscureText;
  }
}
