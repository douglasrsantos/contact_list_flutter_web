import 'package:challenge_uex/app/core/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:challenge_uex/app/modules/home/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class SearchRegisterButtons extends StatelessWidget {
  final Function() clearRegisterFields;
  final Function()? onPressedSearchButton;
  final Function(BuildContext addNewRegisterContext)? onPressedSaveNewContact;
  final Function(String)? onChangedCep;
  final Function(CepModel)? onTapChooseAddressSuggestions;
  final Function()? onPressedSearchAddressSuggestions;
  final List<CepModel> addressSuggestions;
  final bool isLoadingCep;
  final bool isLoadingSearchAddress;
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

  const SearchRegisterButtons({
    super.key,
    required this.clearRegisterFields,
    required this.onPressedSearchButton,
    required this.onPressedSaveNewContact,
    required this.onChangedCep,
    required this.onTapChooseAddressSuggestions,
    required this.onPressedSearchAddressSuggestions,
    required this.addressSuggestions,
    required this.isLoadingCep,
    required this.isLoadingSearchAddress,
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
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onPressedSearchButton,
            label: const Text('Pesquisar'),
            icon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              clearRegisterFields();

              showAdaptiveDialog(
                context: context,
                builder: (addNewRegisterContext) {
                  return AlertDialog.adaptive(
                    title: Text(
                      'CADASTRAR CONTATO',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () =>
                            onPressedSaveNewContact!(addNewRegisterContext),
                        child: const Text('Gravar'),
                      ),
                      ElevatedButton(
                        onPressed: () => addNewRegisterContext.pop(),
                        child: const Text('Cancelar'),
                      ),
                    ],
                    content: Observer(builder: (_) {
                      return ContentDialogNewRegister(
                        isEditing: false,
                        nameController: nameController,
                        cpfController: cpfController,
                        phoneController: phoneController,
                        cepController: cepController,
                        addressController: addressController,
                        complementController: complementController,
                        numberController: numberController,
                        neighborhoodController: neighborhoodController,
                        cityController: cityController,
                        stateController: stateController,
                        searchAddressController: searchAddressController,
                        searchCityController: searchCityController,
                        searchStateController: searchStateController,
                        onChangedCep: onChangedCep,
                        isLoadingCep: isLoadingCep,
                        addressSuggestions: addressSuggestions,
                        isLoadingSearchAddress: isLoadingSearchAddress,
                        onPressedSearchAddressSuggestions:
                            onPressedSearchAddressSuggestions,
                        onTapChooseAddressSuggestions:
                            onTapChooseAddressSuggestions,
                      );
                    }),
                  );
                },
              );
            },
            label: const Text('Cadastrar Novo'),
            icon: const Icon(Icons.new_label_outlined),
          ),
        ),
      ],
    );
  }
}
