import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:challenge_uex/app/core/ui/ui.dart';

class DefaultTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final Function(String value)? onChanged;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final TextCapitalization textCapitalization;

  const DefaultTextFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.readOnly = false,
    this.inputFormatters,
    this.fillColor,
    this.textCapitalization = TextCapitalization.words,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            fillColor: fillColor,
          ),
          obscureText: obscureText,
          style: TextStyle(color: AppColors.primaryColor),
          validator: validator,
          onChanged: onChanged,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
        ),
      ],
    );
  }
}
