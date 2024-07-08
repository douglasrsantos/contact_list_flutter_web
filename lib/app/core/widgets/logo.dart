import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Image.asset(
        'assets/icons/login-icon.png',
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }

          return frame == null
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : child;
        },
      ),
    );
  }
}
