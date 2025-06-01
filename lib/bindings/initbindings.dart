import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:get/get.dart';
import '../controller/configbackendcontroller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
   Get.put(Crud());
   Get.put(ConfigBackendController());
  }
  
}
