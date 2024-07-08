import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import 'package:challenge_uex/app/core/error/error.dart';
import 'package:challenge_uex/app/core/ui/ui.dart';
import 'package:challenge_uex/app/core/widgets/widgets.dart';
import 'package:challenge_uex/app/modules/authentication/register/register.dart';
import 'package:challenge_uex/app/modules/authentication/register/widgets/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RegisterPage extends StatefulWidget {
  final RegisterStore controller;

  const RegisterPage({
    super.key,
    required this.controller,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterStore get controller => widget.controller;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBreakpoints.of(context).isDesktop
          ? Observer(builder: (_) {
              return RegisterPageDesktop(
                isLoading: controller.isLoading,
                isObscureText: controller.isObscureText,
                isObscureTextConfirmPassword:
                    controller.isObscureTextConfirmPassword,
                onPressedSuffixIconPassword:
                    controller.toggleObscureTextPassword,
                onPressedSuffixIconConfirmPassword:
                    controller.toggleObscureTextConfirmPassword,
                formKey: controller.formKey,
                emailController: controller.emailController,
                nameController: controller.nameController,
                passwordController: controller.passwordController,
                confirmPasswordController: controller.confirmPasswordController,
                onPressedSave: () {
                  controller.saveNewUser().then(
                    (_) {
                      if (controller.infoErrorMessage == null) {
                        context.go('/login');
                      }
                    },
                  );
                },
              );
            })
          : Observer(builder: (_) {
              return RegisterPageMobile(
                isLoading: controller.isLoading,
                isObscureText: controller.isObscureText,
                isObscureTextConfirmPassword:
                    controller.isObscureTextConfirmPassword,
                onPressedSuffixIconPassword:
                    controller.toggleObscureTextPassword,
                onPressedSuffixIconConfirmPassword:
                    controller.toggleObscureTextConfirmPassword,
                formKey: controller.formKey,
                emailController: controller.emailController,
                nameController: controller.nameController,
                passwordController: controller.passwordController,
                confirmPasswordController: controller.confirmPasswordController,
                onPressedSave: () {
                  controller.saveNewUser().then(
                    (_) {
                      if (controller.infoErrorMessage == null) {
                        context.go('/login');
                      }
                    },
                  );
                },
              );
            }),
    );
  }
}

class RegisterPageMobile extends StatelessWidget {
  final bool isLoading;
  final bool isObscureText;
  final bool isObscureTextConfirmPassword;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Key formKey;
  final Function()? onPressedSuffixIconPassword;
  final Function()? onPressedSuffixIconConfirmPassword;
  final Function()? onPressedSave;

  const RegisterPageMobile({
    super.key,
    required this.isLoading,
    required this.isObscureText,
    required this.isObscureTextConfirmPassword,
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onPressedSuffixIconPassword,
    required this.onPressedSuffixIconConfirmPassword,
    required this.onPressedSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Logo(),
                  const PageTitle(text: 'LISTA DE CONTATOS'),
                  const SizedBox(height: 16),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : FormRegister(
                          emailController: emailController,
                          nameController: nameController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          formKey: formKey,
                          obscureText: isObscureText,
                          obscureTextConfirmPassword:
                              isObscureTextConfirmPassword,
                          onPressedSuffixIconPassword:
                              onPressedSuffixIconPassword,
                          onPressedSuffixIconConfirmPassword:
                              onPressedSuffixIconConfirmPassword,
                        ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.maxFinite,
                    // height: 40,
                    child: ElevatedButton(
                      onPressed: onPressedSave,
                      child: Text(
                        'CADASTRAR',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  const ReturnToLoginButton(),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class RegisterPageDesktop extends StatelessWidget {
  final bool isLoading;
  final bool isObscureText;
  final bool isObscureTextConfirmPassword;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Key formKey;
  final Function()? onPressedSuffixIconPassword;
  final Function()? onPressedSuffixIconConfirmPassword;
  final Function()? onPressedSave;

  const RegisterPageDesktop({
    super.key,
    required this.isLoading,
    required this.isObscureText,
    required this.isObscureTextConfirmPassword,
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onPressedSuffixIconPassword,
    required this.onPressedSuffixIconConfirmPassword,
    required this.onPressedSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.backgroundGradient,
      ),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: LoginRegisterImage(
                  image: AppImages.registerImage,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.35,
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
                        isLoading
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : FormRegister(
                                emailController: emailController,
                                nameController: nameController,
                                passwordController: passwordController,
                                confirmPasswordController:
                                    confirmPasswordController,
                                formKey: formKey,
                                obscureText: isObscureText,
                                obscureTextConfirmPassword:
                                    isObscureTextConfirmPassword,
                                onPressedSuffixIconPassword:
                                    onPressedSuffixIconPassword,
                                onPressedSuffixIconConfirmPassword:
                                    onPressedSuffixIconConfirmPassword,
                              ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.maxFinite,
                          // height: 40,
                          child: ElevatedButton(
                            onPressed: onPressedSave,
                            child: Text(
                              'CADASTRAR',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                        const ReturnToLoginButton(),
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
