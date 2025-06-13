import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop3/core/app_config.dart';
import 'package:shop3/core/repositories/auth_repo.dart';
import 'package:shop3/core/repositories/products_repo.dart';
import 'package:shop3/core/repositories/profile_repo.dart';
import 'package:shop3/core/services/dio_reqmgr.dart';
// import 'package:shop3/core/services/repository_services/products_service.dart';
// import 'package:shop3/core/services/repository_services/profile_services.dart';
// import 'package:shop3/core/services/repository_services/user_auth_service.dart';

// Create the global locator instance
final GetIt getIt = GetIt.I;
Future<void> serviceLocatorInitializer(AppConfig config) async {
  getIt.registerSingleton(config);

  getIt.registerFactory(() => DioRequestManager(Dio())..initBaseOptions());
  getIt.registerFactory<AuthenticationInterface>(()=>AuthenticationRepo(getIt<DioRequestManager>()));
  getIt.registerFactory<UserProfileInterface>(()=>UserProfileRepo(getIt<DioRequestManager>()));
  getIt.registerFactory<ProductsInterface>(() => ProductsRepo(getIt<DioRequestManager>()));

  // getIt.registerFactory<UserAuthServices>(() => UserAuthServices(getIt<AuthenticationRepo>()));
  // getIt.registerFactory<UserProfileServices>(() => UserProfileServices(getIt<UserProfileInterface>()));
  // getIt.registerFactory<ProductServices>(() => ProductServices(getIt<ProductsInterface>()));
}
