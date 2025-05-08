
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/datasource/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login();

}


class LoginControllerImp extends LoginController{

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  LoginData loginData = LoginData();

  late TextEditingController email;
  late TextEditingController passowrd;

  bool isPassord = true;

  @override
  login() {
    print("login focntionne");
  }

  @override
  void onInit() {
    email= TextEditingController();
    passowrd = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    passowrd.dispose();
    super.dispose();
  }

}