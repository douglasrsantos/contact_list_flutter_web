import 'package:challenge_uex/app_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:challenge_uex/app/core/interfaces/interfaces.dart';
import 'package:challenge_uex/app/core/database/database.dart';
import 'package:challenge_uex/app/core/repositories/repositories.dart';
import 'package:challenge_uex/app/modules/authentication/login/login.dart';
import 'package:challenge_uex/app/modules/authentication/register/register.dart';
import 'package:challenge_uex/app/modules/home/home.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<HiveService>(HiveService());
  getIt.registerLazySingleton<IContact>(
      () => ContactRepository(hiveService: getIt<HiveService>(), Dio()));
  getIt.registerLazySingleton<IUser>(
      () => UserRepository(hiveService: getIt<HiveService>()));
  getIt.registerSingleton<AppStore>(AppStore(
    hiveService: getIt<HiveService>(),
    userRepository: getIt<IUser>(),
  ));
  getIt.registerSingleton<HomeStore>(HomeStore(
    app: getIt<AppStore>(),
    userRepository: getIt<IUser>(),
    contactRepository: getIt<IContact>(),
    hiveService: getIt<HiveService>(),
  ));
  getIt.registerFactory<LoginStore>(() => LoginStore(app: getIt<AppStore>()));
  getIt.registerFactory<RegisterStore>(
      () => RegisterStore(userRepository: getIt<IUser>()));
}
