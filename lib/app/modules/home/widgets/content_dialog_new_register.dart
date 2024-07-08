import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mask/mask.dart';

import 'package:challenge_uex/app/core/models/models.dart';
import 'package:challenge_uex/app/core/widgets/widgets.dart';
import 'package:challenge_uex/app/modules/home/widgets/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContentDialogNewRegister extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController cpfController;
  final TextEditingController phoneController;
  final TextEditingController cepController;
  final TextEditingController addressController;
  final TextEditingController complementController;
  final TextEditingController numberController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController searchAddressController;
  final TextEditingController searchCityController;
  final TextEditingController searchStateController;
  final Function(String value)? onChangedCep;
  final bool isLoadingCep;
  final List<CepModel> addressSuggestions;
  final bool isLoadingSearchAddress;
  final Function()? onPressedSearchAddressSuggestions;
  final Function(CepModel choosedAddress)? onTapChooseAddressSuggestions;
  final bool isEditing;

  const ContentDialogNewRegister({
    super.key,
    required this.nameController,
    required this.cpfController,
    required this.phoneController,
    required this.cepController,
    required this.addressController,
    required this.complementController,
    required this.numberController,
    required this.neighborhoodController,
    required this.cityController,
    required this.stateController,
    required this.searchAddressController,
    required this.searchCityController,
    required this.searchStateController,
    required this.onChangedCep,
    required this.isLoadingCep,
    required this.addressSuggestions,
    required this.isLoadingSearchAddress,
    required this.onPressedSearchAddressSuggestions,
    required this.onTapChooseAddressSuggestions,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        maxWidth: ResponsiveBreakpoints.of(context).isDesktop
            ? MediaQuery.of(context).size.width * 0.6
            : MediaQuery.of(context).size.width,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextFormField(
              title: 'Nome',
              hintText: 'Insira o nome do contato',
              controller: nameController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Nome deve ser preenchido';
                }
                return null;
              },
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Flexible(
                  child: DefaultTextFormField(
                    title: 'CPF',
                    hintText: 'Insira o CPF do contato',
                    controller: cpfController,
                    inputFormatters: [Mask.cpf()],
                    validator: (value) => Mask.validations.cpf(value),
                    readOnly: isEditing ? true : false,
                    fillColor:
                        isEditing ? Colors.grey.shade500 : Colors.grey.shade100,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: DefaultTextFormField(
                    title: 'Telefone',
                    hintText: 'Insira o nº do telefone do contato',
                    controller: phoneController,
                    inputFormatters: [Mask.phone()],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Telefone deve ser preenchido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 5,
                  child: DefaultTextFormField(
                    title: 'CEP',
                    hintText: 'Insira o CEP do contato',
                    controller: cepController,
                    inputFormatters: [
                      Mask.generic(masks: ['#####-###'], hashtag: Hashtag.numbers)
                    ],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'CEP deve ser preenchido';
                      }
                      return null;
                    },
                    onChanged: onChangedCep,
                  ),
                ),
                const SizedBox(width: 8),
                isLoadingCep
                    ? const CircularProgressIndicator.adaptive()
                    : Tooltip(
                        message: 'Pesquisar endereço',
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(48),
                          ),
                          onPressed: () {
                            _clearSearchFields(
                              searchAddressController: searchAddressController,
                              searchCityController: searchCityController,
                              searchStateController: searchStateController,
                              isLoadingSearchAddress: isLoadingSearchAddress,
                              addressSuggestions: addressSuggestions,
                            );
        
                            showAdaptiveDialog(
                              context: context,
                              builder: (searchAddressContext) {
                                return AlertDialog.adaptive(
                                  title: Text(
                                    'PESQUISAR ENDEREÇO',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed:
                                          onPressedSearchAddressSuggestions,
                                      child: const Text('Pesquisar'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => searchAddressContext.pop(),
                                      child: const Text('Cancelar'),
                                    ),
                                  ],
                                  content: Observer(builder: (_) {
                                    return ContentDialogSearchAddress(
                                      searchAddressController:
                                          searchAddressController,
                                      searchCityController: searchCityController,
                                      searchStateController:
                                          searchStateController,
                                      addressSuggestions: addressSuggestions,
                                      isLoadingSearchAddress:
                                          isLoadingSearchAddress,
                                      onTapChooseAddressSuggestions:
                                          onTapChooseAddressSuggestions,
                                    );
                                  }),
                                );
                              },
                            );
                          },
                          label: const Icon(Icons.search),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: DefaultTextFormField(
                    title: 'Endereço',
                    hintText: 'Insira o endereço do contato',
                    controller: addressController,
                    readOnly: isLoadingCep ? true : false,
                    fillColor: isLoadingCep ? Colors.grey.shade500 : null,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Endereço deve ser preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: DefaultTextFormField(
                    title: 'Número',
                    hintText: 'Insira o número do endereço',
                    controller: numberController,
                    readOnly: isLoadingCep ? true : false,
                    fillColor: isLoadingCep ? Colors.grey.shade500 : null,
                    inputFormatters: [
                      Mask.generic(
                          masks: ['#############'], hashtag: Hashtag.numbers)
                    ],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Número deve ser preenchido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            DefaultTextFormField(
              title: 'Complemento',
              hintText: 'Insira o complemento do endereço',
              controller: complementController,
              readOnly: isLoadingCep ? true : false,
              fillColor: isLoadingCep ? Colors.grey.shade500 : null,
              validator: null,
            ),
            const SizedBox(height: 4),
            DefaultTextFormField(
              title: 'Bairro',
              hintText: 'Insira o bairro do contato',
              controller: neighborhoodController,
              readOnly: isLoadingCep ? true : false,
              fillColor: isLoadingCep ? Colors.grey.shade500 : null,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Bairro deve ser preenchido';
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
                    hintText: 'Insira a cidade do contato',
                    controller: cityController,
                    readOnly: isLoadingCep ? true : false,
                    fillColor: isLoadingCep ? Colors.grey.shade500 : null,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Cidade deve ser preenchido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: DefaultTextFormField(
                    title: 'Estado',
                    hintText: 'Insira o estado do contato',
                    controller: stateController,
                    readOnly: isLoadingCep ? true : false,
                    fillColor: isLoadingCep ? Colors.grey.shade500 : null,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Estado deve ser preenchido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _clearSearchFields({
  required TextEditingController searchAddressController,
  required TextEditingController searchCityController,
  required TextEditingController searchStateController,
  required bool isLoadingSearchAddress,
  required List<CepModel> addressSuggestions,
}) {
  searchAddressController.text = '';
  searchCityController.text = '';
  searchStateController.text = '';
  isLoadingSearchAddress = false;
  addressSuggestions.clear();
}
