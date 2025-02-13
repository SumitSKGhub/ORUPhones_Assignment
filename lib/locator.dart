import 'package:get_it/get_it.dart';
import 'package:oruphones/core/services/auth_service.dart';
import 'package:oruphones/core/services/product_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ProductService());
}