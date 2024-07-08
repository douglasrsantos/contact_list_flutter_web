import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import 'package:challenge_uex/app/core/error/error.dart';
import 'package:challenge_uex/app/core/ui/ui.dart';
import 'package:challenge_uex/app/core/widgets/widgets.dart';
import 'package:challenge_uex/app/modules/authentication/login/login.dart';
import 'package:challenge_uex/app/modules/authentication/login/widgets/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LoginPage extends StatefulWidget {
  final LoginStore controller;

  const LoginPage({
    super.key,
    required this.controller,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStore get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    reaction((_) => controller.infoErrorMessage, (_) {
      if (controller.hasError) {
        Messages.of(context).showError(controller.infoErrorMessage!);
      }
    });

    reaction((_) => controller.infoSuccessMessage, (_) {
      if (controller.hasSuccess) {
        Messages.of(context).showSuccess(controller.infoSuccessMessage!);
      }
    });

    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBreakpoints.of(context).isDesktop
          ? Observer(builder: (_) {
              return LoginPageDesktop(
                  emailController: controller.emailController,
                  passwordController: controller.passwordController,
                  formKey: controller.formKey,
                  obscureText: controller.isObscureText,
                  onPressedSuffixIconPassword:
                      controller.toggleObscureTextPassword,
                  onPressedLogin: () {
                    controller.login().then(
                      (_) {
                        if (controller.infoErrorMessage == null) {
                          context.go('/home');
                        }
                      },
                    );
                  });
            })
          : Observer(builder: (_) {
              return LoginPageMobile(
                emailController: controller.emailController,
                passwordController: controller.passwordController,
                formKey: controller.formKey,
                obscureText: controller.isObscureText,
                onPressedSuffixIconPassword:
                    controller.toggleObscureTextPassword,
                onPressedLogin: () {
                  controller.login().then(
                    (_) {
                      if (controller.infoErrorMessage == null) {
                        context.go('/home');
                      }
                    },
                  );
                },
              );
            }),
    );
  }
}

class LoginPageDesktop extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Function()? onPressedLogin;
  final bool obscureText;
  final Function()? onPressedSuffixIconPassword;

  const LoginPageDesktop({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.onPressedLogin,
    required this.obscureText,
    required this.onPressedSuffixIconPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.backgroundGradient,
      ),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginRegisterImage(
                image: AppImages.loginImage,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Logo(),
                        const PageTitle(text: 'LISTA DE CONTATOS'),
                        const SizedBox(height: 16),
                        FormEmailPassword(
                          emailController: emailController,
                          passwordController: passwordController,
                          formKey: formKey,
                          obscureText: obscureText,
                          onPressedSuffixIconPassword:
                              onPressedSuffixIconPassword,
                        ),
                        const SizedBox(height: 16),
                        LoginRegisterButtons(
                          onPressedLogin: onPressedLogin,
                          onPressedRegister: () => context.go('/register'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPageMobile extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Function()? onPressedLogin;
  final bool obscureText;
  final Function()? onPressedSuffixIconPassword;

  const LoginPageMobile({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.onPressedLogin,
    required this.obscureText,
    required this.onPressedSuffixIconPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.backgroundGradient,
      ),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Logo(),
                  const PageTitle(text: 'LISTA DE CONTATOS'),
                  const SizedBox(height: 16),
                  FormEmailPassword(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                    obscureText: obscureText,
                    onPressedSuffixIconPassword: onPressedSuffixIconPassword,
                  ),
                  const SizedBox(height: 16),
                  LoginRegisterButtons(
                    onPressedLogin: onPressedLogin,
                    onPressedRegister: () => context.go('/register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
