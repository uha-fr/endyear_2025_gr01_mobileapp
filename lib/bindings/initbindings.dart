import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:get/get.dart';
import '../controller/configbackendcontroller.dart';
import '../controller/auth/login_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
   Get.put(Crud());
   Get.put(ConfigBackendController());
   // Register LoginControllerImp for global access
   Get.lazyPut(() => LoginControllerImp(), fenix: true);
  }
  
}
