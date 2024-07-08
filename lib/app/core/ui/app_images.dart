import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static Widget loginImage = SvgPicture.asset(
    'assets/login.svg',
    fit: BoxFit.cover,
    placeholderBuilder: (_) {
      return const Center(
          child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ));
    },
  );
  static Widget registerImage = SvgPicture.asset(
    'assets/register.svg',
    fit: BoxFit.cover,
    placeholderBuilder: (_) {
      return const Center(
          child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ));
    },
  );
}
