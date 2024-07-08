// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: 'AppStoreBase.hasError'))
      .value;
  Computed<UserModel?>? _$userComputed;

  @override
  UserModel? get user => (_$userComputed ??=
          Computed<UserModel?>(() => super.user, name: 'AppStoreBase.user'))
      .value;
  Computed<bool>? _$isLoggedComputed;

  @override
  bool get isLogged => (_$isLoggedComputed ??=
          Computed<bool>(() => super.isLogged, name: 'AppStoreBase.isLogged'))
      .value;

  late final _$infoErrorMessageAtom =
      Atom(name: 'AppStoreBase.infoErrorMessage', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: 'AppStoreBase.isLoading', context: context);

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

  late final _$_userAtom = Atom(name: 'AppStoreBase._user', context: context);

  @override
  UserModel? get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(UserModel? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$tryLoginWithUserEmailAsyncAction =
      AsyncAction('AppStoreBase.tryLoginWithUserEmail', context: context);

  @override
  Future<void> tryLoginWithUserEmail() {
    return _$tryLoginWithUserEmailAsyncAction
        .run(() => super.tryLoginWithUserEmail());
  }

  late final _$loginAsyncAction =
      AsyncAction('AppStoreBase.login', context: context);

  @override
  Future<void> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AppStoreBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$syncUserAsyncAction =
      AsyncAction('AppStoreBase.syncUser', context: context);

  @override
  Future<void> syncUser() {
    return _$syncUserAsyncAction.run(() => super.syncUser());
  }

  @override
  String toString() {
    return '''
infoErrorMessage: ${infoErrorMessage},
isLoading: ${isLoading},
hasError: ${hasError},
user: ${user},
isLogged: ${isLogged}
    ''';
  }
}
