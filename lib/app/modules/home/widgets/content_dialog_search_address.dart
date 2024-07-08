import 'package:challenge_uex/app/core/ui/app_colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask/mask.dart';

import 'package:challenge_uex/app/core/models/models.dart';
import 'package:challenge_uex/app/core/ui/ui.dart';
import 'package:challenge_uex/app/core/widgets/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContentDialogSearchAddress extends StatelessWidget {
  final TextEditingController searchAddressController;
  final TextEditingController searchCityController;
  final TextEditingController searchStateController;
  final List<CepModel> addressSuggestions;
  final bool isLoadingSearchAddress;
  final Function(CepModel choosedAddress)? onTapChooseAddressSuggestions;

  const ContentDialogSearchAddress({
    super.key,
    required this.searchAddressController,
    required this.searchCityController,
    required this.searchStateController,
    required this.addressSuggestions,
    required this.isLoadingSearchAddress,
    required this.onTapChooseAddressSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: ResponsiveBreakpoints.of(context).isDesktop
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextFormField(
            title: 'Endereço',
            hintText: 'Insira o endereço para pesquisar',
            controller: searchAddressController,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Endereço deve ser preenchido';
              }
              return null;
            },
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Flexible(
                flex: 4,
                child: DefaultTextFormField(
                  title: 'Cidade',
                  hintText: 'Insira a cidade para pesquisar',
                  controller: searchCityController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Cidade deve ser preenchida';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: DefaultTextFormField(
                  title: 'UF',
                  hintText: 'Insira a UF para pesquisar',
                  controller: searchStateController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'UF deve ser preenchido';
                    }
                    return null;
                  },
                  inputFormatters: [
                    Mask.generic(masks: ['##'], hashtag: Hashtag.letters),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Observer(builder: (_) {
            if (isLoadingSearchAddress) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (addressSuggestions.isEmpty) {
              return const Expanded(
                child: Center(
                  child: NoDataWidget(
                    title: 'Não foram encontrados endereços!',
                    subtitle:
                        'Preencha os campos para fazer uma pesquisa de endereço',
                    icon: Icons.pin_drop_outlined,
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: addressSuggestions.length,
                separatorBuilder: (_, index) => const Divider(),
                itemBuilder: (context, index) {
                  final address = addressSuggestions[index];

                  return InkWell(
                    onTap: () {
                      onTapChooseAddressSuggestions!(address);
                      context.pop();
                    },
                    child: Text(
                      _buildAddress(address),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

String _buildAddress(CepModel address) {
  List<String> addressParts = [];

  if (address.road != null) {
    addressParts.add(address.road!);
  }

  if (address.neighborhood != null) {
    addressParts.add(address.neighborhood!);
  }

  if (address.city != null) {
    addressParts.add(address.city!);
  }

  if (address.state != null) {
    addressParts.add(address.state!);
  }

  if (address.cep != null) {
    addressParts.add(address.cep!);
  }

  if (address.complement != null) {
    addressParts.add(address.complement!);
  }

  final resultAddress = addressParts.join(', ');
  return resultAddress;
}
