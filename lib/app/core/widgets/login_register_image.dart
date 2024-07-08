import 'package:flutter/material.dart';

class LoginRegisterImage extends StatelessWidget {
  final Widget image;

  const LoginRegisterImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: image,
    );
  }
}
