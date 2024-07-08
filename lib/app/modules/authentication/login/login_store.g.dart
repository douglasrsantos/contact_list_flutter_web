// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: 'LoginStoreBase.hasError'))
      .value;
  Computed<bool>? _$hasSuccessComputed;

  @override
  bool get hasSuccess =>
      (_$hasSuccessComputed ??= Computed<bool>(() => super.hasSuccess,
              name: 'LoginStoreBase.hasSuccess'))
          .value;

  late final _$infoErrorMessageAtom =
      Atom(name: 'LoginStoreBase.infoErrorMessage', context: context);

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
      Atom(name: 'LoginStoreBase.infoSuccessMessage', context: context);

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
      Atom(name: 'LoginStoreBase.isLoading', context: context);

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
      Atom(name: 'LoginStoreBase.isObscureText', context: context);

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

  late final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase', context: context);

  @override
  void toggleObscureTextPassword() {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.toggleObscureTextPassword');
    try {
      return super.toggleObscureTextPassword();
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
infoErrorMessage: ${infoErrorMessage},
infoSuccessMessage: ${infoSuccessMessage},
isLoading: ${isLoading},
isObscureText: ${isObscureText},
hasError: ${hasError},
hasSuccess: ${hasSuccess}
    ''';
  }
}
