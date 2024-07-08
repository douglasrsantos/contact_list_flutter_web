import 'package:flutter/material.dart';

import 'package:challenge_uex/app/core/ui/ui.dart';
import 'package:challenge_uex/app/core/widgets/widgets.dart';

class FormEmailPassword extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Key formKey;
  final bool obscureText;
  final Function()? onPressedSuffixIconPassword;

  const FormEmailPassword({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.obscureText,
    required this.onPressedSuffixIconPassword,
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
          const SizedBox(height: 16),
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
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
