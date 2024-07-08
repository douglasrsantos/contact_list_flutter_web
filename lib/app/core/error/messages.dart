import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

import 'package:challenge_uex/app/core/ui/ui.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void showError(String title) => _showMessage(title, true);

  void showSuccess(String title) => _showMessage(title, false);

  void _showMessage(String title, bool hasError) {
    if (hasError) {
      CherryToast.error(
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        backgroundColor: Colors.white,
        animationDuration: const Duration(seconds: 1),
        animationType: AnimationType.fromBottom,
        toastPosition: Position.bottom,
        borderRadius: 4,
        displayCloseButton: false,
        iconWidget: Icon(
          Icons.warning_amber_rounded,
          size: 32,
          color: AppColors.primaryColorDark,
        ),
      ).show(context);
    } else {
      CherryToast.success(
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        backgroundColor: Colors.white,
        animationDuration: const Duration(seconds: 1),
        animationType: AnimationType.fromBottom,
        toastPosition: Position.bottom,
        borderRadius: 4,
        displayCloseButton: false,
        iconWidget: Icon(
          Icons.check_circle,
          size: 32,
          color: AppColors.primaryColorDark,
        ),
      ).show(context);
    }
  }
}
