import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  void logout() async {
    print("MyServices logout started");
    await sharedPreferences.clear();
    print("MyServices SharedPreferences cleared");
   
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
