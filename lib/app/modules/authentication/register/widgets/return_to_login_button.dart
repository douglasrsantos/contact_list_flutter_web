import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReturnToLoginButton extends StatelessWidget {
  const ReturnToLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go('/login'),
      style: TextButton.styleFrom(
        elevation: 0,
        overlayColor: Colors.transparent,
      ),
      child: Text(
        'Já sou cadastrado. Fazer Login!',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
