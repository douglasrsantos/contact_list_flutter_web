import 'package:challenge_uex/app/core/database/database.dart';
import 'package:challenge_uex/app/core/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import 'package:challenge_uex/app/core/interfaces/interfaces.dart';
import 'package:challenge_uex/app_store.dart';
import 'package:challenge_uex/routes.dart';

part 'home_store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final AppStore app;
  final IUser userRepository;
  final IContact contactRepository;
  final HiveService hiveService;

  HomeStoreBase({
    required this.app,
    required this.userRepository,
    required this.contactRepository,
    required this.hiveService,
  });

  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneController = TextEditingController();
  final cepController = TextEditingController();
  final addressController = TextEditingController();
  final complementController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  final searchAddressController = TextEditingController();
  final searchCityController = TextEditingController();
  final searchStateController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  GoogleMapController? mapController;

  @observable
  String? infoErrorMessage;

  @computed
  bool get hasError => infoErrorMessage != null;

  @observable
  String? infoSuccessMessage;

  @computed
  bool get hasSuccess => infoSuccessMessage != null;

  @observable
  UserModel? user;

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingCep = false;

  @observable
  bool isLoadingSearchAddress = false;

  @observable
  bool enableSearchField = false;

  @observable
  bool isObscureText = true;

  @observable
  bool isObscureTextConfirmPassword = true;

  @observable
  ObservableList<ContactModel> contacts = ObservableList<ContactModel>();

  @observable
  ObservableList<CepModel> addressSuggestions = ObservableList<CepModel>();

  @observable
  double lat = -29.5354;

  @observable
  double long = -49.9157;

  ContactModel contact = ContactModel();

  ///Initialize Screen
  void init() async {
    if (!app.isLogged) {
      routes.go('/login');
      return;
    }

    user = app.user;

    await getContacsByUser();
  }

  ///Logout
  Future<void> logout() async {
    infoErrorMessage = null;

    try {
      await userRepository.logout();
      routes.go('/login');
    } catch (e) {
      infoErrorMessage = e.toString();
    }
  }

  ///Deletes the user's account and deletes all contacts created by the user
  Future<void> deleteAccount() async {
    infoErrorMessage = null;
    infoSuccessMessage = null;

    try {
      if (passwordController.text != confirmPasswordController.text) {
        throw 'Senhas diferentes. Conta não foi excluída';
      }

      await userRepository.deleteAccount(
          email: app.user?.email ?? '', password: passwordController.text);
      infoSuccessMessage = 'Conta excluída com sucesso';
    } catch (e) {
      infoErrorMessage = e.toString();
    }
  }

  ///Get all contacts created by user
  @action
  Future<void> getContacsByUser() async {
    infoErrorMessage = null;
    isLoading = true;
    try {
      final result = await contactRepository.getContactsCreatedByUser(
          email: user?.email ?? '');

      result?.sort(
          (a, b) => (a.contactName ?? '').compareTo(b.contactName ?? ''));

      contacts.clear();
      contacts.addAll(result ?? []);
    } catch (e) {
      infoErrorMessage = e.toString();
    }
    isLoading = false;
  }

  ///Fill in the contact model for saving and editing the contact
  Future<void> fillContact() async {
    contact.contactCreatorEmail = app.user?.email ?? '';
    contact.address = addressController.text;
    contact.cep = cepController.text.replaceAll('-', '');
    contact.city = cityController.text;
    contact.complement = complementController.text;
    contact.contactName = nameController.text;
    contact.cpf =
        cpfController.text.replaceAll('.', '').replaceAll('-', '').trim();
    contact.neighborhood = neighborhoodController.text;
    contact.number = numberController.text;
    contact.phone = phoneController.text
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('-', '')
        .replaceAll(' ', '');
    contact.state = stateController.text;
    contact.lat = -29.5354;
    contact.long = -49.9157;
  }

  ///Save a new contact
  @action
  Future<void> saveContact() async {
    infoErrorMessage = null;
    infoSuccessMessage = null;
    isLoading = true;
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      if (!validateFields()) {
        isLoading = false;
        throw 'Você precisa preencher os campos necessários!';
      }

      await fillContact();
      await getCoordinates();
      await contactRepository.createContact(contact: contact);

      await getContacsByUser();
      infoSuccessMessage = 'Contato criado com sucesso!';
    } catch (e) {
      infoErrorMessage = e.toString();
    }
    isLoading = false;
  }

  ///Edit a contact
  @action
  Future<void> updateContact() async {
    infoErrorMessage = null;
    infoSuccessMessage = null;
    isLoading = true;
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      if (!validateFields()) {
        isLoading = false;
        throw 'Você precisa preencher os campos necessários!';
      }

      await fillContact();
      await getCoordinates();
      await contactRepository.updateContact(
        contact: contact,
        email: app.user?.email ?? '',
      );

      await getContacsByUser();
      infoSuccessMessage = 'Contato editado com sucesso!';
    } catch (e) {
      infoErrorMessage = e.toString();
    }
    isLoading = false;
  }

  ///Delete a contact
  @action
  Future<void> deleteContact(String cpf) async {
    infoErrorMessage = null;
    infoSuccessMessage = null;
    isLoading = true;
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      await contactRepository.deleteContactCreatedByUser(
        cpf: cpf,
      );

      await getContacsByUser();
      infoSuccessMessage = 'Contato excluído com sucesso!';
    } catch (e) {
      infoErrorMessage = e.toString();
    }
    isLoading = false;
  }

  ///Search for an address using the cepcom query on the ViaCep API
  @action
  Future<void> getAddressWithCep() async {
    infoErrorMessage = null;
    infoSuccessMessage = null;
    isLoadingCep = true;
    try {
      final result =
          await contactRepository.getAddressWithCep(cepController.text);

      fillChoosedAddress(result);
    } catch (e) {
      infoErrorMessage = e.toString();
    }
    isLoadingCep = false;
  }

  ///Searches for address suggestions in the ViaCep API based on information provided by the user
  @action
  Future<void> getAddressSuggestions() async {
    infoErrorMessage = null;
    infoSuccessMessage = null;
    isLoadingSearchAddress = true;

    try {
      if (searchAddressController.text.trim().isEmpty ||
          searchCityController.text.trim().isEmpty ||
          searchStateController.text.trim().isEmpty) {
        isLoadingSearchAddress = false;
        throw 'Preencha todos os campos para pesquisar';
      }

      final result = await contactRepository.getAddressSuggestions(
        state: searchStateController.text,
        city: searchCityController.text,
        address: searchAddressController.text,
      );

      addressSuggestions.clear();
      addressSuggestions.addAll(result);
    } catch (e) {
      infoErrorMessage = e.toString();
    }

    isLoadingSearchAddress = false;
  }

  ///Uses GooglePlaces API services to fetch the geographic coordinates of the address provided by the user
  @action
  Future<void> getCoordinates() async {
    infoErrorMessage = null;

    try {
      final result = await contactRepository
          .getCoordinatesFromAddress(concatenatedAddress(contact));

      if (result.isNotEmpty) {
        contact.lat = result['lat'];
        contact.long = result['long'];
      }
    } catch (e) {
      rethrow;
    }
  }

  ///Fill in the fields for the address selected on the address suggestion screen
  void fillChoosedAddress(CepModel choosedAddress) {
    cepController.text = choosedAddress.cep ?? '';
    addressController.text = choosedAddress.road ?? '';
    complementController.text = choosedAddress.complement ?? '';
    neighborhoodController.text = choosedAddress.neighborhood ?? '';
    cityController.text = choosedAddress.city ?? '';
    stateController.text = choosedAddress.state ?? '';
  }

  ///Concatenates the address and transforms it into a single string to display in the contact list
  String concatenatedAddress(ContactModel contact) {
    List<String> addressParts = [];

    if (contact.address != null) {
      addressParts.add(contact.address!);
    }

    if (contact.number != null) {
      addressParts.add(contact.number!);
    }

    if (contact.neighborhood != null) {
      addressParts.add(contact.neighborhood!);
    }

    if (contact.city != null) {
      addressParts.add(contact.city!);
    }

    if (contact.state != null) {
      addressParts.add(contact.state!);
    }

    if (contact.cep != null) {
      addressParts.add(contact.cep!);
    }

    if (contact.complement != null) {
      addressParts.add(contact.complement!);
    }

    final resultAddress = addressParts.join(', ');
    return resultAddress;
  }

  ///Formats the phone number searched in the database for display in the initial contact list
  String returnFormattedPhone(String phone) {
    if (phone.isEmpty) return '';

    List<String> phoneParts = [];

    phoneParts.add('(');
    phoneParts.add(phone.trim().substring(0, 2));
    phoneParts.add(')');
    phoneParts.add(phone.trim().substring(2, 7));
    phoneParts.add('-');
    phoneParts.add(phone.trim().substring(7, 11));

    final formattedPhone = phoneParts.join();

    return formattedPhone;
  }

  ///Toggles the obscureText property of the Password field
  @action
  void toggleObscureTextPassword() {
    isObscureText = !isObscureText;
  }

  ///Toggles the obscureText property of the Confirm Password field
  @action
  void toggleObscureTextConfirmPassword() {
    isObscureTextConfirmPassword = !isObscureTextConfirmPassword;
  }

  ///Toggles the display of the search field in the initial listing
  @action
  Future<void> toggleEnableSearchField() async {
    enableSearchField = !enableSearchField;

    if (!enableSearchField) {
      searchController.text = '';
      await getContacsByUser();
    }
  }

  ///Fill in the text fields for editing the contact
  void fillFieldsToUpdate(ContactModel contact) {
    nameController.text = contact.contactName ?? '';
    cpfController.text = contact.cpf ?? '';
    phoneController.text = contact.phone ?? '';
    cepController.text = contact.cep ?? '';
    addressController.text = contact.address ?? '';
    complementController.text = contact.complement ?? '';
    numberController.text = contact.number ?? '';
    neighborhoodController.text = contact.neighborhood ?? '';
    cityController.text = contact.city ?? '';
    stateController.text = contact.state ?? '';
  }

  ///Clear the text fields for registering a new contact
  void clearRegisterFields() {
    nameController.text = '';
    cpfController.text = '';
    phoneController.text = '';
    cepController.text = '';
    addressController.text = '';
    complementController.text = '';
    numberController.text = '';
    neighborhoodController.text = '';
    cityController.text = '';
    stateController.text = '';
  }

  ///Validates the mandatory fields for registering and editing a new contact
  bool validateFields() {
    if (nameController.text.trim().isEmpty) {
      return false;
    }
    if (cpfController.text.trim().isEmpty) {
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      return false;
    }
    if (cepController.text.trim().isEmpty) {
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      return false;
    }
    if (numberController.text.trim().isEmpty) {
      return false;
    }
    if (neighborhoodController.text.trim().isEmpty) {
      return false;
    }
    if (cityController.text.trim().isEmpty) {
      return false;
    }
    if (stateController.text.trim().isEmpty) {
      return false;
    }

    return true;
  }

  ///Clear form fields for account deletion
  void clearFieldsDeleteAccount() {
    passwordController.text = '';
    confirmPasswordController.text = '';
    isObscureText = true;
    isObscureTextConfirmPassword = true;
  }

  ///Filter contacts by query
  @action
  Future<void> searchContacts() async {
    if (searchController.text.trim().isEmpty || contacts.isEmpty) {
      await getContacsByUser();
    }

    List<ContactModel> filteredContacts = [];

    final queryLowerCase = searchController.text.toLowerCase();

    for (ContactModel contact in contacts) {
      if (contact.contactName!.toLowerCase().contains(queryLowerCase) ||
          contact.cpf!.toLowerCase().contains(queryLowerCase)) {
        filteredContacts.add(contact);
      }
    }

    contacts.clear();
    contacts.addAll(filteredContacts);
  }
}
