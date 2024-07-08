import 'package:flutter/material.dart';

import 'package:challenge_uex/app/modules/authentication/login/widgets/widgets.dart';

class LoginRegisterButtons extends StatelessWidget {
  final Function()? onPressedLogin;
  final Function()? onPressedRegister;

  const LoginRegisterButtons({
    super.key,
    required this.onPressedLogin,
    required this.onPressedRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onPressedLogin,
          child: Text(
            'ENTRAR',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(width: 16),
        RegisterButton(onPressedRegister: onPressedRegister),
      ],
    );
  }
}
