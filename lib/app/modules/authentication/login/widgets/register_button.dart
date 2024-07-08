import 'package:flutter/material.dart';

import 'package:challenge_uex/app/core/ui/ui.dart';

class RegisterButton extends StatelessWidget {
  final Function()? onPressedRegister;

  const RegisterButton({
    super.key,
    required this.onPressedRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressedRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: AppColors.primaryColorLight),
          ),
        ),
        child: Text(
          'CADASTRE-SE',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
