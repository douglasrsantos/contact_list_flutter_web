import 'package:flutter/material.dart';

import 'package:challenge_uex/app/core/ui/ui.dart';

class AppGradients {
  static LinearGradient backgroundGradient = LinearGradient(
    colors: [
      AppColors.primaryColor,
      AppColors.primaryColorLight,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
