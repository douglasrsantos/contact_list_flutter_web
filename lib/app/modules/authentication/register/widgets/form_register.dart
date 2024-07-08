import 'package:challenge_uex/app/core/ui/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:challenge_uex/app/core/widgets/widgets.dart';

class FormRegister extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Key formKey;
  final bool obscureText;
  final bool obscureTextConfirmPassword;
  final Function()? onPressedSuffixIconPassword;
  final Function()? onPressedSuffixIconConfirmPassword;

  const FormRegister({
    super.key,
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.obscureText,
    required this.obscureTextConfirmPassword,
    required this.onPressedSuffixIconPassword,
    required this.onPressedSuffixIconConfirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextFormField(
            title: 'Nome',
            hintText: 'Insira seu nome',
            controller: nameController,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Nome deve ser informado.';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          DefaultTextFormField(
            title: 'E-mail',
            hintText: 'seuemail@seuemail.com',
            controller: emailController,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'E-mail deve ser informado.';
              } else if (!value.contains('@')) {
                return 'E-mail inválido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          DefaultTextFormField(
            title: 'Senha',
            hintText: 'Insira sua senha',
            controller: passwordController,
            obscureText: obscureText,
            suffixIcon: IconButton(
              onPressed: onPressedSuffixIconPassword,
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.primaryColor,
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Senha deve ser informada.';
              } else if (value.length < 6) {
                return 'Deve conter no mínimo 6 caracteres.';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          DefaultTextFormField(
            title: 'Confirmação de senha',
            hintText: 'Insira novamente sua senha',
            controller: confirmPasswordController,
            obscureText: obscureTextConfirmPassword,
            suffixIcon: IconButton(
              onPressed: onPressedSuffixIconConfirmPassword,
              icon: Icon(
                obscureTextConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.primaryColor,
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Confirmação de senha deve ser informada.';
              } else if (value != passwordController.text) {
                return 'Senhas diferentes.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
