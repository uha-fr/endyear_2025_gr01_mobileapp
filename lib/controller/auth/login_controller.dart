
import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../core/class/statusrequest.dart';
import '../../data/datasource/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login();

}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  LoginData loginData = LoginData();

  late TextEditingController email;
  late TextEditingController password;

  bool isShowPassword = true;


  StatusRequest statusRequest = StatusRequest.none;

  @override
  login() async {
      print("login fonctionne");
      Get.offNamed(
              AppRoutes.homePage,
            );
  }

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }



  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
