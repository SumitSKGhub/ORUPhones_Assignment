import 'package:get_it/get_it.dart';
import 'package:oruphones/core/services/auth_service.dart';
import 'package:oruphones/core/services/bottom_sheet_service.dart';
import 'package:oruphones/core/services/faq_service.dart';
import 'package:oruphones/core/services/permission_service.dart';
import 'package:oruphones/core/services/product_service.dart';
import 'package:oruphones/ui/views/auth/auth_viewmodel.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => PermissionService());
  locator.registerLazySingleton(() => FAQService());

}