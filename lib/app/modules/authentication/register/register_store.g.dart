// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on RegisterStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: 'RegisterStoreBase.hasError'))
          .value;
  Computed<bool>? _$hasSuccessComputed;

  @override
  bool get hasSuccess =>
      (_$hasSuccessComputed ??= Computed<bool>(() => super.hasSuccess,
              name: 'RegisterStoreBase.hasSuccess'))
          .value;

  late final _$infoErrorMessageAtom =
      Atom(name: 'RegisterStoreBase.infoErrorMessage', context: context);

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
      Atom(name: 'RegisterStoreBase.infoSuccessMessage', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: 'RegisterStoreBase.isLoading', context: context);

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

  late final _$isObscureTextAtom =
      Atom(name: 'RegisterStoreBase.isObscureText', context: context);

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
      name: 'RegisterStoreBase.isObscureTextConfirmPassword', context: context);

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

  late final _$RegisterStoreBaseActionController =
      ActionController(name: 'RegisterStoreBase', context: context);

  @override
  void toggleObscureTextPassword() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.toggleObscureTextPassword');
    try {
      return super.toggleObscureTextPassword();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleObscureTextConfirmPassword() {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.toggleObscureTextConfirmPassword');
    try {
      return super.toggleObscureTextConfirmPassword();
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
infoErrorMessage: ${infoErrorMessage},
infoSuccessMessage: ${infoSuccessMessage},
isLoading: ${isLoading},
isObscureText: ${isObscureText},
isObscureTextConfirmPassword: ${isObscureTextConfirmPassword},
hasError: ${hasError},
hasSuccess: ${hasSuccess}
    ''';
  }
}
