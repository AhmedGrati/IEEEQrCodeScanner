import 'package:get_it/get_it.dart';
import 'package:qr_code_ieee/service/partner_service.dart';
import 'package:qr_code_ieee/service/user_service.dart';
class ServiceSetUp {

  ServiceSetUp() {
    GetIt.I.registerLazySingleton(() => UserService());
    GetIt.I.registerLazySingleton(() => PartnerService());
  }
}