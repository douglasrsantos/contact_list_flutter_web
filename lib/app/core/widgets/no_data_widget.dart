import 'package:flutter/material.dart';

import 'package:challenge_uex/app/core/ui/ui.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const NoDataWidget({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColorDark,
          ),
          child: Icon(
            icon,
            size: 100,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          subtitle ?? '',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppColors.primaryColorDark),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
