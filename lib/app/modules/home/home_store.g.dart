// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: 'HomeStoreBase.hasError'))
      .value;
  Computed<bool>? _$hasSuccessComputed;

  @override
  bool get hasSuccess =>
      (_$hasSuccessComputed ??= Computed<bool>(() => super.hasSuccess,
              name: 'HomeStoreBase.hasSuccess'))
          .value;

  late final _$infoErrorMessageAtom =
      Atom(name: 'HomeStoreBase.infoErrorMessage', context: context);

  @override
  String? get infoErrorMessage {
    _$infoErrorMessageAtom.reportRead();
    return super.infoErrorMessage;
  }

  @override
  set infoErrorMessage(String? value) {
    _$infoErrorMessageAtom.reportWrite(value, super.infoErrorMessage, () {
      super.infoErrorMessage = value;
    });
  }

  late final _$infoSuccessMessageAtom =
      Atom(name: 'HomeStoreBase.infoSuccessMessage', context: context);

  @override
  String? get infoSuccessMessage {
    _$infoSuccessMessageAtom.reportRead();
    return super.infoSuccessMessage;
  }

  @override
  set infoSuccessMessage(String? value) {
    _$infoSuccessMessageAtom.reportWrite(value, super.infoSuccessMessage, () {
      super.infoSuccessMessage = value;
    });
  }

  late final _$userAtom = Atom(name: 'HomeStoreBase.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoadingCepAtom =
      Atom(name: 'HomeStoreBase.isLoadingCep', context: context);

  @override
  bool get isLoadingCep {
    _$isLoadingCepAtom.reportRead();
    return super.isLoadingCep;
  }

  @override
  set isLoadingCep(bool value) {
    _$isLoadingCepAtom.reportWrite(value, super.isLoadingCep, () {
      super.isLoadingCep = value;
    });
  }

  late final _$isLoadingSearchAddressAtom =
      Atom(name: 'HomeStoreBase.isLoadingSearchAddress', context: context);

  @override
  bool get isLoadingSearchAddress {
    _$isLoadingSearchAddressAtom.reportRead();
    return super.isLoadingSearchAddress;
  }

  @override
  set isLoadingSearchAddress(bool value) {
    _$isLoadingSearchAddressAtom
        .reportWrite(value, super.isLoadingSearchAddress, () {
      super.isLoadingSearchAddress = value;
    });
  }

  late final _$enableSearchFieldAtom =
      Atom(name: 'HomeStoreBase.enableSearchField', context: context);

  @override
  bool get enableSearchField {
    _$enableSearchFieldAtom.reportRead();
    return super.enableSearchField;
  }

  @override
  set enableSearchField(bool value) {
    _$enableSearchFieldAtom.reportWrite(value, super.enableSearchField, () {
      super.enableSearchField = value;
    });
  }

  late final _$isObscureTextAtom =
      Atom(name: 'HomeStoreBase.isObscureText', context: context);

  @override
  bool get isObscureText {
    _$isObscureTextAtom.reportRead();
    return super.isObscureText;
  }

  @override
  set isObscureText(bool value) {
    _$isObscureTextAtom.reportWrite(value, super.isObscureText, () {
      super.isObscureText = value;
    });
  }

  late final _$isObscureTextConfirmPasswordAtom = Atom(
      name: 'HomeStoreBase.isObscureTextConfirmPassword', context: context);

  @override
  bool get isObscureTextConfirmPassword {
    _$isObscureTextConfirmPasswordAtom.reportRead();
    return super.isObscureTextConfirmPassword;
  }

  @override
  set isObscureTextConfirmPassword(bool value) {
    _$isObscureTextConfirmPasswordAtom
        .reportWrite(value, super.isObscureTextConfirmPassword, () {
      super.isObscureTextConfirmPassword = value;
    });
  }

  late final _$contactsAtom =
      Atom(name: 'HomeStoreBase.contacts', context: context);

  @override
  ObservableList<ContactModel> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<ContactModel> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$addressSuggestionsAtom =
      Atom(name: 'HomeStoreBase.addressSuggestions', context: context);

  @override
  ObservableList<CepModel> get addressSuggestions {
    _$addressSuggestionsAtom.reportRead();
    return super.addressSuggestions;
  }

  @override
  set addressSuggestions(ObservableList<CepModel> value) {
    _$addressSuggestionsAtom.reportWrite(value, super.addressSuggestions, () {
      super.addressSuggestions = value;
    });
  }

  late final _$latAtom = Atom(name: 'HomeStoreBase.lat', context: context);

  @override
  double get lat {
    _$latAtom.reportRead();
    return super.lat;
  }

  @override
  set lat(double value) {
    _$latAtom.reportWrite(value, super.lat, () {
      super.lat = value;
    });
  }

  late final _$longAtom = Atom(name: 'HomeStoreBase.long', context: context);

  @override
  double get long {
    _$longAtom.reportRead();
    return super.long;
  }

  @override
  set long(double value) {
    _$longAtom.reportWrite(value, super.long, () {
      super.long = value;
    });
  }

  late final _$getContacsByUserAsyncAction =
      AsyncAction('HomeStoreBase.getContacsByUser', context: context);

  @override
  Future<void> getContacsByUser() {
    return _$getContacsByUserAsyncAction.run(() => super.getContacsByUser());
  }

  late final _$saveContactAsyncAction =
      AsyncAction('HomeStoreBase.saveContact', context: context);

  @override
  Future<void> saveContact() {
    return _$saveContactAsyncAction.run(() => super.saveContact());
  }

  late final _$updateContactAsyncAction =
      AsyncAction('HomeStoreBase.updateContact', context: context);

  @override
  Future<void> updateContact() {
    return _$updateContactAsyncAction.run(() => super.updateContact());
  }

  late final _$deleteContactAsyncAction =
      AsyncAction('HomeStoreBase.deleteContact', context: context);

  @override
  Future<void> deleteContact(String cpf) {
    return _$deleteContactAsyncAction.run(() => super.deleteContact(cpf));
  }

  late final _$getAddressWithCepAsyncAction =
      AsyncAction('HomeStoreBase.getAddressWithCep', context: context);

  @override
  Future<void> getAddressWithCep() {
    return _$getAddressWithCepAsyncAction.run(() => super.getAddressWithCep());
  }

  late final _$getAddressSuggestionsAsyncAction =
      AsyncAction('HomeStoreBase.getAddressSuggestions', context: context);

  @override
  Future<void> getAddressSuggestions() {
    return _$getAddressSuggestionsAsyncAction
        .run(() => super.getAddressSuggestions());
  }

  late final _$getCoordinatesAsyncAction =
      AsyncAction('HomeStoreBase.getCoordinates', context: context);

  @override
  Future<void> getCoordinates() {
    return _$getCoordinatesAsyncAction.run(() => super.getCoordinates());
  }

  late final _$toggleEnableSearchFieldAsyncAction =
      AsyncAction('HomeStoreBase.toggleEnableSearchField', context: context);

  @override
  Future<void> toggleEnableSearchField() {
    return _$toggleEnableSearchFieldAsyncAction
        .run(() => super.toggleEnableSearchField());
  }

  late final _$searchContactsAsyncAction =
      AsyncAction('HomeStoreBase.searchContacts', context: context);

  @override
  Future<void> searchContacts() {
    return _$searchContactsAsyncAction.run(() => super.searchContacts());
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void toggleObscureTextPassword() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.toggleObscureTextPassword');
    try {
      return super.toggleObscureTextPassword();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleObscureTextConfirmPassword() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.toggleObscureTextConfirmPassword');
    try {
      return super.toggleObscureTextConfirmPassword();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
infoErrorMessage: ${infoErrorMessage},
infoSuccessMessage: ${infoSuccessMessage},
user: ${user},
isLoading: ${isLoading},
isLoadingCep: ${isLoadingCep},
isLoadingSearchAddress: ${isLoadingSearchAddress},
enableSearchField: ${enableSearchField},
isObscureText: ${isObscureText},
isObscureTextConfirmPassword: ${isObscureTextConfirmPassword},
contacts: ${contacts},
addressSuggestions: ${addressSuggestions},
lat: ${lat},
long: ${long},
hasError: ${hasError},
hasSuccess: ${hasSuccess}
    ''';
  }
}
