import 'package:challenge_uex/app/core/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import 'package:challenge_uex/app/core/error/error.dart';
import 'package:challenge_uex/app/core/ui/ui.dart';
import 'package:challenge_uex/app/core/widgets/widgets.dart';
import 'package:challenge_uex/app/modules/home/home.dart';
import 'package:challenge_uex/app/modules/home/widgets/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends StatefulWidget {
  final HomeStore controller;

  const HomePage({
    super.key,
    required this.controller,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    reaction((_) => controller.infoErrorMessage, (_) {
      if (controller.hasError) {
        Messages.of(context).showError(controller.infoErrorMessage!);
      }
    });

    reaction((_) => controller.infoSuccessMessage, (_) {
      if (controller.hasSuccess) {
        Messages.of(context).showSuccess(controller.infoSuccessMessage!);
      }
    });

    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBreakpoints.of(context).isDesktop
          ? Observer(builder: (_) {
              return HomePageDesktop(
                nameController: controller.nameController,
                cpfController: controller.cpfController,
                phoneController: controller.phoneController,
                cepController: controller.cepController,
                addressController: controller.addressController,
                complementController: controller.complementController,
                numberController: controller.numberController,
                neighborhoodController: controller.neighborhoodController,
                cityController: controller.cityController,
                stateController: controller.stateController,
                searchAddressController: controller.searchAddressController,
                searchCityController: controller.searchCityController,
                searchStateController: controller.searchStateController,
                passwordController: controller.passwordController,
                confirmPasswordController: controller.confirmPasswordController,
                searchController: controller.searchController,
                formKey: controller.formKey,
                mapController: controller.mapController,
                enableSearchField: controller.enableSearchField,
                isLoadingCep: controller.isLoadingCep,
                isLoadingSearchAddress: controller.isLoadingSearchAddress,
                addressSuggestions: controller.addressSuggestions,
                contacts: controller.contacts,
                completeAddress: (contact) =>
                    controller.concatenatedAddress(contact),
                formattedPhone: (phone) =>
                    controller.returnFormattedPhone(phone),
                userName: controller.user?.name ?? '',
                lat: controller.lat,
                long: controller.long,
                clearRegisterFields: controller.clearRegisterFields,
                onPressedSearchButton: controller.toggleEnableSearchField,
                onPressedSaveNewContact: (addNewRegisterContext) async {
                  await controller.saveContact().then((_) {
                    if (controller.infoErrorMessage == null &&
                        controller.infoSuccessMessage != null) {
                      addNewRegisterContext.pop();
                    }
                  });
                },
                onChangedCep: (value) {
                  if (value.trim().length == 9) {
                    controller.getAddressWithCep();
                  }
                },
                onPressedSearchAddressSuggestions:
                    controller.getAddressSuggestions,
                onTapChooseAddressSuggestions: (choosedAddress) =>
                    controller.fillChoosedAddress(choosedAddress),
                onTapContact: (contact) {
                  controller.lat = contact.lat ?? 0;
                  controller.long = contact.long ?? 0;
                  controller.mapController?.moveCamera(CameraUpdate.newLatLng(
                    LatLng(controller.lat, controller.long),
                  ));
                },
                onPressedSaveContact: (addNewRegisterContext) async {
                  await controller.updateContact().then((_) {
                    if (controller.infoErrorMessage == null &&
                        controller.infoSuccessMessage != null) {
                      addNewRegisterContext.pop();
                    }
                  });
                },
                onPressedDeleteContact: (cpf) => controller.deleteContact(cpf),
                fillFieldsToUpdate: (contact) =>
                    controller.fillFieldsToUpdate(contact),
                onTapLogout: controller.logout,
                onPressedDeleteAccount: (dialogDeleteAccountContext) async {
                  await controller.deleteAccount().then(
                    (_) {
                      if (controller.infoErrorMessage == null) {
                        dialogDeleteAccountContext.pop();
                        context.go('/login');
                      } else {
                        dialogDeleteAccountContext.pop();
                      }
                    },
                  );
                },
                clearFieldsDeleteAccount: controller.clearFieldsDeleteAccount,
                onMapCreated: (controllerMap) {
                  controller.mapController = controllerMap;
                },
                onChangedSearchField: (value) => controller.searchContacts(),
                passwordTextField: Observer(builder: (_) {
                  return DefaultTextFormField(
                    title: 'Senha',
                    hintText: 'Insira sua senha',
                    controller: controller.passwordController,
                    obscureText: controller.isObscureText,
                    suffixIcon: IconButton(
                      onPressed: controller.toggleObscureTextPassword,
                      icon: Icon(
                        controller.isObscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Senha deve ser informada.';
                      } else if (value.length < 6) {
                        return 'Deve conter no mínimo 6 caracteres.';
                      }
                      return null;
                    },
                  );
                }),
                confirmPasswordTextField: Observer(builder: (_) {
                  return DefaultTextFormField(
                    title: 'Confirmação de senha',
                    hintText: 'Insira novamente sua senha',
                    controller: controller.confirmPasswordController,
                    obscureText: controller.isObscureTextConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: controller.toggleObscureTextConfirmPassword,
                      // toggleObscureTextConfirmPassword,
                      icon: Icon(
                        controller.isObscureTextConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Confirmação de senha deve ser informada.';
                      } else if (value != controller.passwordController.text) {
                        return 'Senhas diferentes.';
                      }
                      return null;
                    },
                  );
                }),
              );
            })
          : Observer(builder: (_) {
              return HomePageMobile(
                nameController: controller.nameController,
                cpfController: controller.cpfController,
                phoneController: controller.phoneController,
                cepController: controller.cepController,
                addressController: controller.addressController,
                complementController: controller.complementController,
                numberController: controller.numberController,
                neighborhoodController: controller.neighborhoodController,
                cityController: controller.cityController,
                stateController: controller.stateController,
                searchAddressController: controller.searchAddressController,
                searchCityController: controller.searchCityController,
                searchStateController: controller.searchStateController,
                passwordController: controller.passwordController,
                confirmPasswordController: controller.confirmPasswordController,
                searchController: controller.searchController,
                formKey: controller.formKey,
                mapController: controller.mapController,
                enableSearchField: controller.enableSearchField,
                isLoadingCep: controller.isLoadingCep,
                isLoadingSearchAddress: controller.isLoadingSearchAddress,
                addressSuggestions: controller.addressSuggestions,
                contacts: controller.contacts,
                completeAddress: (contact) =>
                    controller.concatenatedAddress(contact),
                formattedPhone: (phone) =>
                    controller.returnFormattedPhone(phone),
                userName: controller.user?.name ?? '',
                lat: controller.lat,
                long: controller.long,
                clearRegisterFields: controller.clearRegisterFields,
                onPressedSearchButton: controller.toggleEnableSearchField,
                onPressedSaveNewContact: (addNewRegisterContext) async {
                  await controller.saveContact().then((_) {
                    if (controller.infoErrorMessage == null &&
                        controller.infoSuccessMessage != null) {
                      addNewRegisterContext.pop();
                    }
                  });
                },
                onChangedCep: (value) {
                  if (value.trim().length == 9) {
                    controller.getAddressWithCep();
                  }
                },
                onPressedSearchAddressSuggestions:
                    controller.getAddressSuggestions,
                onTapChooseAddressSuggestions: (choosedAddress) =>
                    controller.fillChoosedAddress(choosedAddress),
                onTapContact: (contact) {
                  controller.lat = contact.lat ?? 0;
                  controller.long = contact.long ?? 0;
                  controller.mapController?.moveCamera(CameraUpdate.newLatLng(
                    LatLng(controller.lat, controller.long),
                  ));
                },
                onChangedSearchField: (value) => controller.searchContacts(),
                onPressedSaveContact: (addNewRegisterContext) async {
                  await controller.updateContact().then((_) {
                    if (controller.infoErrorMessage == null &&
                        controller.infoSuccessMessage != null) {
                      addNewRegisterContext.pop();
                    }
                  });
                },
                onPressedDeleteContact: (cpf) => controller.deleteContact(cpf),
                fillFieldsToUpdate: (contact) =>
                    controller.fillFieldsToUpdate(contact),
                onTapLogout: controller.logout,
                onPressedDeleteAccount: (dialogDeleteAccountContext) async {
                  await controller.deleteAccount().then(
                    (_) {
                      if (controller.infoErrorMessage == null) {
                        dialogDeleteAccountContext.pop();
                        context.go('/login');
                      } else {
                        dialogDeleteAccountContext.pop();
                      }
                    },
                  );
                },
                clearFieldsDeleteAccount: controller.clearFieldsDeleteAccount,
                onMapCreated: (controllerMap) {
                  controller.mapController = controllerMap;
                },
                passwordTextField: Observer(builder: (_) {
                  return DefaultTextFormField(
                    title: 'Senha',
                    hintText: 'Insira sua senha',
                    controller: controller.passwordController,
                    obscureText: controller.isObscureText,
                    suffixIcon: IconButton(
                      onPressed: controller.toggleObscureTextPassword,
                      icon: Icon(
                        controller.isObscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Senha deve ser informada.';
                      } else if (value.length < 6) {
                        return 'Deve conter no mínimo 6 caracteres.';
                      }
                      return null;
                    },
                  );
                }),
                confirmPasswordTextField: Observer(builder: (_) {
                  return DefaultTextFormField(
                    title: 'Confirmação de senha',
                    hintText: 'Insira novamente sua senha',
                    controller: controller.confirmPasswordController,
                    obscureText: controller.isObscureTextConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: controller.toggleObscureTextConfirmPassword,
                      // toggleObscureTextConfirmPassword,
                      icon: Icon(
                        controller.isObscureTextConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Confirmação de senha deve ser informada.';
                      } else if (value != controller.passwordController.text) {
                        return 'Senhas diferentes.';
                      }
                      return null;
                    },
                  );
                }),
              );
            }),
    );
  }
}

class HomePageDesktop extends StatefulWidget {
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
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController searchController;
  final GlobalKey<FormState> formKey;
  final GoogleMapController? mapController;
  final bool enableSearchField;
  final bool isLoadingCep;
  final bool isLoadingSearchAddress;
  final List<CepModel> addressSuggestions;
  final List<ContactModel> contacts;
  final String userName;
  final double lat;
  final double long;
  final Function(String phone) formattedPhone;
  final Function(ContactModel contact) completeAddress;
  final Function() clearRegisterFields;
  final Function()? onPressedSearchButton;
  final Function(BuildContext)? onPressedSaveNewContact;
  final Function(String)? onChangedCep;
  final Function()? onPressedSearchAddressSuggestions;
  final Function(CepModel)? onTapChooseAddressSuggestions;
  final Function(ContactModel contact)? onTapContact;
  final Function(BuildContext)? onPressedSaveContact;
  final Function(String cpf)? onPressedDeleteContact;
  final Function(ContactModel contact) fillFieldsToUpdate;
  final Function()? onTapLogout;
  final Function(BuildContext)? onPressedDeleteAccount;
  final Function() clearFieldsDeleteAccount;
  final Function(GoogleMapController)? onMapCreated;
  final Function(String value)? onChangedSearchField;
  final Widget passwordTextField;
  final Widget confirmPasswordTextField;

  const HomePageDesktop({
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
    required this.passwordController,
    required this.confirmPasswordController,
    required this.searchController,
    required this.formKey,
    required this.mapController,
    required this.enableSearchField,
    required this.isLoadingCep,
    required this.isLoadingSearchAddress,
    required this.addressSuggestions,
    required this.contacts,
    required this.userName,
    required this.lat,
    required this.long,
    required this.formattedPhone,
    required this.completeAddress,
    required this.clearRegisterFields,
    required this.onPressedSearchButton,
    required this.onPressedSaveNewContact,
    required this.onChangedCep,
    required this.onPressedSearchAddressSuggestions,
    required this.onTapChooseAddressSuggestions,
    required this.onTapContact,
    required this.onPressedSaveContact,
    required this.onPressedDeleteContact,
    required this.fillFieldsToUpdate,
    required this.onTapLogout,
    required this.onPressedDeleteAccount,
    required this.clearFieldsDeleteAccount,
    required this.onMapCreated,
    required this.onChangedSearchField,
    required this.passwordTextField,
    required this.confirmPasswordTextField,
  });

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.48,
              color: AppColors.primaryColor,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Observer(builder: (_) {
                    return Column(
                      children: [
                        const PageTitle(text: 'CONTATOS CADASTRADOS'),
                        const Divider(),
                        const SizedBox(height: 8),
                        if (widget.enableSearchField)
                          TextFormField(
                            controller: widget.searchController,
                            style: TextStyle(color: AppColors.primaryColor),
                            decoration: InputDecoration(
                                hintText: 'Pesquisar',
                                prefixIcon: const Icon(Icons.search),
                                prefixIconColor:
                                    AppColors.primaryColor.withOpacity(0.5)),
                            onChanged: widget.onChangedSearchField,
                          ),
                        if (widget.enableSearchField) const SizedBox(height: 8),
                        SearchRegisterButtons(
                          clearRegisterFields: widget.clearRegisterFields,
                          onPressedSearchButton: widget.onPressedSearchButton,
                          onPressedSaveNewContact:
                              widget.onPressedSaveNewContact,
                          onChangedCep: widget.onChangedCep,
                          onPressedSearchAddressSuggestions:
                              widget.onPressedSearchAddressSuggestions,
                          onTapChooseAddressSuggestions:
                              widget.onTapChooseAddressSuggestions,
                          addressSuggestions: widget.addressSuggestions,
                          isLoadingCep: widget.isLoadingCep,
                          isLoadingSearchAddress: widget.isLoadingSearchAddress,
                          nameController: widget.nameController,
                          cpfController: widget.cpfController,
                          phoneController: widget.phoneController,
                          cepController: widget.cepController,
                          addressController: widget.addressController,
                          complementController: widget.complementController,
                          numberController: widget.numberController,
                          neighborhoodController: widget.neighborhoodController,
                          cityController: widget.cityController,
                          stateController: widget.stateController,
                          searchAddressController:
                              widget.searchAddressController,
                          searchCityController: widget.searchCityController,
                          searchStateController: widget.searchStateController,
                        ),
                        Observer(builder: (_) {
                          if (widget.contacts.isEmpty) {
                            return const Expanded(
                              child: Center(
                                child: NoDataWidget(
                                  title: 'Não foram encontrados contatos!',
                                  subtitle:
                                      'Clique em cadastrar novo para criar contato.',
                                  icon: Icons.contact_phone,
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(top: 8),
                              itemCount: widget.contacts.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final contact = widget.contacts[index];

                                return ContactsListTile(
                                  onTapContact: () =>
                                      widget.onTapContact!(contact),
                                  onPressedSaveContact:
                                      widget.onPressedSaveContact,
                                  onPressedDeleteContact: () =>
                                      widget.onPressedDeleteContact!(
                                          contact.cpf ?? ''),
                                  fillFieldsToUpdate: () =>
                                      widget.fillFieldsToUpdate(contact),
                                  onChangedCep: widget.onChangedCep,
                                  onPressedSearchAddressSuggestions:
                                      widget.onPressedSearchAddressSuggestions,
                                  onTapChooseAddressSuggestions:
                                      widget.onTapChooseAddressSuggestions,
                                  addressSuggestions: widget.addressSuggestions,
                                  contactName: contact.contactName ?? '',
                                  completeAddress:
                                      widget.completeAddress(contact),
                                  formattedPhone: widget
                                      .formattedPhone(contact.phone ?? ''),
                                  isLoadingCep: widget.isLoadingCep,
                                  isLoadingSearchAddress:
                                      widget.isLoadingSearchAddress,
                                  nameController: widget.nameController,
                                  cpfController: widget.cpfController,
                                  phoneController: widget.phoneController,
                                  cepController: widget.cepController,
                                  addressController: widget.addressController,
                                  complementController:
                                      widget.complementController,
                                  numberController: widget.numberController,
                                  neighborhoodController:
                                      widget.neighborhoodController,
                                  cityController: widget.cityController,
                                  stateController: widget.stateController,
                                  searchAddressController:
                                      widget.searchAddressController,
                                  searchCityController:
                                      widget.searchCityController,
                                  searchStateController:
                                      widget.searchStateController,
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Observer(builder: (_) {
              return PopUpUserMenu(
                onTapLogout: widget.onTapLogout,
                onPressedDeleteAccount: widget.onPressedDeleteAccount,
                clearFieldsDeleteAccount: widget.clearFieldsDeleteAccount,
                userName: widget.userName,
                passwordTextField: widget.passwordTextField,
                confirmPasswordTextField: widget.confirmPasswordTextField,
              );
            }),
          ],
        ),
        Expanded(
          child: SizedBox(
            child: Center(
              child: Observer(builder: (_) {
                return GoogleMap(
                  markers: {
                    Marker(
                      markerId: const MarkerId('marker_1'),
                      position: LatLng(widget.lat, widget.long),
                      infoWindow: const InfoWindow(
                        title: 'My Marker',
                        snippet: 'Description',
                      ),
                    ),
                  },
                  onMapCreated: widget.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.long),
                    zoom: 12,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class HomePageMobile extends StatefulWidget {
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
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController searchController;
  final GlobalKey<FormState> formKey;
  final GoogleMapController? mapController;
  final bool enableSearchField;
  final bool isLoadingCep;
  final bool isLoadingSearchAddress;
  final List<CepModel> addressSuggestions;
  final List<ContactModel> contacts;
  final String userName;
  final double lat;
  final double long;
  final String Function(String) formattedPhone;
  final String Function(ContactModel contact) completeAddress;
  final Function() clearRegisterFields;
  final Function()? onPressedSearchButton;
  final Function(BuildContext)? onPressedSaveNewContact;
  final Function(String)? onChangedCep;
  final Function()? onPressedSearchAddressSuggestions;
  final Function(CepModel)? onTapChooseAddressSuggestions;
  final Function(ContactModel contact)? onTapContact;
  final Function(BuildContext)? onPressedSaveContact;
  final Function(String cpf)? onPressedDeleteContact;
  final Function(ContactModel contact) fillFieldsToUpdate;
  final Function()? onTapLogout;
  final Function(BuildContext)? onPressedDeleteAccount;
  final Function() clearFieldsDeleteAccount;
  final Function(GoogleMapController)? onMapCreated;
  final Function(String value)? onChangedSearchField;
  final Widget passwordTextField;
  final Widget confirmPasswordTextField;

  const HomePageMobile({
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
    required this.passwordController,
    required this.confirmPasswordController,
    required this.searchController,
    required this.formKey,
    required this.mapController,
    required this.enableSearchField,
    required this.isLoadingCep,
    required this.isLoadingSearchAddress,
    required this.addressSuggestions,
    required this.contacts,
    required this.userName,
    required this.lat,
    required this.long,
    required this.formattedPhone,
    required this.completeAddress,
    required this.clearRegisterFields,
    required this.onPressedSearchButton,
    required this.onPressedSaveNewContact,
    required this.onChangedCep,
    required this.onPressedSearchAddressSuggestions,
    required this.onTapChooseAddressSuggestions,
    required this.onTapContact,
    required this.onPressedSaveContact,
    required this.onPressedDeleteContact,
    required this.fillFieldsToUpdate,
    required this.onTapLogout,
    required this.onPressedDeleteAccount,
    required this.clearFieldsDeleteAccount,
    required this.onMapCreated,
    required this.onChangedSearchField,
    required this.passwordTextField,
    required this.confirmPasswordTextField,
  });

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              color: AppColors.primaryColor,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Observer(builder: (_) {
                    return Column(
                      children: [
                        const PageTitle(text: 'CONTATOS CADASTRADOS'),
                        const Divider(),
                        const SizedBox(height: 8),
                        if (widget.enableSearchField)
                          TextFormField(
                            controller: widget.searchController,
                            style: TextStyle(color: AppColors.primaryColor),
                            decoration: InputDecoration(
                                hintText: 'Pesquisar',
                                prefixIcon: const Icon(Icons.search),
                                prefixIconColor:
                                    AppColors.primaryColor.withOpacity(0.5)),
                            onChanged: widget.onChangedSearchField,
                          ),
                        if (widget.enableSearchField) const SizedBox(height: 8),
                        SearchRegisterButtons(
                          clearRegisterFields: widget.clearRegisterFields,
                          onPressedSearchButton: widget.onPressedSearchButton,
                          onPressedSaveNewContact:
                              widget.onPressedSaveNewContact,
                          onChangedCep: widget.onChangedCep,
                          onPressedSearchAddressSuggestions:
                              widget.onPressedSearchAddressSuggestions,
                          onTapChooseAddressSuggestions:
                              widget.onTapChooseAddressSuggestions,
                          addressSuggestions: widget.addressSuggestions,
                          isLoadingCep: widget.isLoadingCep,
                          isLoadingSearchAddress: widget.isLoadingSearchAddress,
                          nameController: widget.nameController,
                          cpfController: widget.cpfController,
                          phoneController: widget.phoneController,
                          cepController: widget.cepController,
                          addressController: widget.addressController,
                          complementController: widget.complementController,
                          numberController: widget.numberController,
                          neighborhoodController: widget.neighborhoodController,
                          cityController: widget.cityController,
                          stateController: widget.stateController,
                          searchAddressController:
                              widget.searchAddressController,
                          searchCityController: widget.searchCityController,
                          searchStateController: widget.searchStateController,
                        ),
                        Observer(builder: (_) {
                          if (widget.contacts.isEmpty) {
                            return const Expanded(
                              child: Center(
                                child: NoDataWidget(
                                  title: 'Não foram encontrados contatos!',
                                  subtitle:
                                      'Clique em cadastrar novo para criar contato.',
                                  icon: Icons.contact_phone,
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(top: 8),
                              itemCount: widget.contacts.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final contact = widget.contacts[index];

                                return ContactsListTile(
                                  onTapContact: () =>
                                      widget.onTapContact!(contact),
                                  onPressedSaveContact:
                                      widget.onPressedSaveContact,
                                  onPressedDeleteContact: () =>
                                      widget.onPressedDeleteContact!(
                                          contact.cpf ?? ''),
                                  fillFieldsToUpdate: () =>
                                      widget.fillFieldsToUpdate(contact),
                                  onChangedCep: widget.onChangedCep,
                                  onPressedSearchAddressSuggestions:
                                      widget.onPressedSearchAddressSuggestions,
                                  onTapChooseAddressSuggestions:
                                      widget.onTapChooseAddressSuggestions,
                                  addressSuggestions: widget.addressSuggestions,
                                  contactName: contact.contactName ?? '',
                                  completeAddress:
                                      widget.completeAddress(contact),
                                  formattedPhone: widget
                                      .formattedPhone(contact.phone ?? ''),
                                  isLoadingCep: widget.isLoadingCep,
                                  isLoadingSearchAddress:
                                      widget.isLoadingSearchAddress,
                                  nameController: widget.nameController,
                                  cpfController: widget.cpfController,
                                  phoneController: widget.phoneController,
                                  cepController: widget.cepController,
                                  addressController: widget.addressController,
                                  complementController:
                                      widget.complementController,
                                  numberController: widget.numberController,
                                  neighborhoodController:
                                      widget.neighborhoodController,
                                  cityController: widget.cityController,
                                  stateController: widget.stateController,
                                  searchAddressController:
                                      widget.searchAddressController,
                                  searchCityController:
                                      widget.searchCityController,
                                  searchStateController:
                                      widget.searchStateController,
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Observer(builder: (_) {
              return PopUpUserMenu(
                onTapLogout: widget.onTapLogout,
                onPressedDeleteAccount: widget.onPressedDeleteAccount,
                clearFieldsDeleteAccount: widget.clearFieldsDeleteAccount,
                userName: widget.userName,
                passwordTextField: widget.passwordTextField,
                confirmPasswordTextField: widget.confirmPasswordTextField,
              );
            }),
          ],
        ),
        Expanded(
          child: SizedBox(
            child: Center(
              child: Observer(builder: (_) {
                return GoogleMap(
                  markers: {
                    Marker(
                      markerId: const MarkerId('marker_1'),
                      position: LatLng(widget.lat, widget.long),
                      infoWindow: const InfoWindow(
                        title: 'My Marker',
                        snippet: 'Description',
                      ),
                    ),
                  },
                  onMapCreated: widget.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.long),
                    zoom: 12,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
