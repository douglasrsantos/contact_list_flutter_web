import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import 'package:challenge_uex/app/core/ui/ui.dart';

class PopUpUserMenu extends StatelessWidget {
  final Function()? onTapLogout;
  final Function(BuildContext dialogDeleteAccountContext)?
      onPressedDeleteAccount;
  final Function() clearFieldsDeleteAccount;
  final String userName;
  final Widget passwordTextField;
  final Widget confirmPasswordTextField;

  const PopUpUserMenu({
    super.key,
    required this.onTapLogout,
    required this.onPressedDeleteAccount,
    required this.clearFieldsDeleteAccount,
    required this.userName,
    required this.passwordTextField,
    required this.confirmPasswordTextField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 32),
      child: Observer(builder: (_) {
        return PopupMenuButton(
          tooltip: 'Menu do usuário',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              )
            ],
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: onTapLogout,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sair',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Icon(
                      Icons.logout,
                      color: AppColors.primaryColor,
                      size: 18,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  clearFieldsDeleteAccount();

                  showAdaptiveDialog(
                    context: context,
                    builder: (dialogDeleteAccountContext) {
                      return Observer(builder: (_) {
                        return AlertDialog.adaptive(
                          title: Text(
                            'INFORME A SENHA PARA DELETAR A SUA CONTA',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () => onPressedDeleteAccount!(
                                  dialogDeleteAccountContext),
                              child: const Text('Excluir Conta'),
                            ),
                            ElevatedButton(
                              onPressed: () => dialogDeleteAccountContext.pop(),
                              child: const Text('Cancelar'),
                            ),
                          ],
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              passwordTextField,
                              const SizedBox(height: 8),
                              confirmPasswordTextField,
                            ],
                          ),
                        );
                      });
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Excluir conta',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Icon(
                      Icons.person_off,
                      color: AppColors.primaryColor,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ];
          },
        );
      }),
    );
  }
}
