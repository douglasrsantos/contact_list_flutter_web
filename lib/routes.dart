import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:challenge_uex/service_locator.dart';

import 'package:challenge_uex/app/modules/authentication/login/login.dart';
import 'package:challenge_uex/app/modules/authentication/register/register.dart';
import 'package:challenge_uex/app/modules/home/home.dart';

final routes = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: LoginPage(
              controller: getIt<LoginStore>(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        }),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: RegisterPage(
            controller: getIt<RegisterStore>(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return HomePage(
          controller: getIt<HomeStore>(),
        );
      },
    ),
  ],
);
