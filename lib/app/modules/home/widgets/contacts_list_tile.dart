import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import 'package:challenge_uex/app/core/models/models.dart';
import 'package:challenge_uex/app/core/ui/ui.dart';
import 'package:challenge_uex/app/modules/home/widgets/widgets.dart';

class ContactsListTile extends StatelessWidget {
  final Function()? onTapContact;
  final Function(BuildContext addNewRegisterContext)? onPressedSaveContact;
  final Function()? onPressedDeleteContact;
  final Function() fillFieldsToUpdate;
  final Function(String)? onChangedCep;
  final Function(CepModel)? onTapChooseAddressSuggestions;
  final Function()? onPressedSearchAddressSuggestions;
  final List<CepModel> addressSuggestions;
  final String contactName;
  final String completeAddress;
  final String formattedPhone;
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

  const ContactsListTile({
    super.key,
    required this.onTapContact,
    required this.onPressedSaveContact,
    required this.onPressedDeleteContact,
    required this.fillFieldsToUpdate,
    required this.onChangedCep,
    required this.onTapChooseAddressSuggestions,
    required this.onPressedSearchAddressSuggestions,
    required this.addressSuggestions,
    required this.contactName,
    required this.completeAddress,
    required this.formattedPhone,
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
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: onTapContact,
      title: Text(
        contactName,
        style: Theme.of(context).textTheme.titleLarge,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            completeAddress,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryColorDark,
                ),
          ),
          Text(
            formattedPhone,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryColorDark,
                ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onPressedDeleteContact,
            tooltip: 'Excluir Cadastro',
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              fillFieldsToUpdate();

              showAdaptiveDialog(
                context: context,
                builder: (addNewRegisterContext) {
                  return AlertDialog.adaptive(
                    title: Text(
                      'EDITAR CONTATO',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () =>
                            onPressedSaveContact!(addNewRegisterContext),
                        child: const Text('Gravar'),
                      ),
                      ElevatedButton(
                        onPressed: () => addNewRegisterContext.pop(),
                        child: const Text('Cancelar'),
                      ),
                    ],
                    content: Observer(builder: (_) {
                      return ContentDialogNewRegister(
                          isEditing: true,
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
                              onTapChooseAddressSuggestions);
                    }),
                  );
                },
              );
            },
            tooltip: 'Editar Cadastro',
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
