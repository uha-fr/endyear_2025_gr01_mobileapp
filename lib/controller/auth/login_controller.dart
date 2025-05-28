import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:endyear_2025_gr01_mobileapp/core/functions/handlingdatacontroller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../data/datasource/remote/auth/login.dart';
import '../../data/datasource/models/employee_model.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  LoginData loginData = LoginData(Get.find());

  late TextEditingController email;
  late TextEditingController password;

  bool isShowPassword = true;

  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find(); // pour utiliser SharedPreference
  
  void logout() {
    myServices.sharedPreferences.clear();
    Get.offNamed(AppRoutes.login);
  }
  
  @override
  login() async {
        var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(email.text, password.text);
      print("response ");
      if (response is Map) {
        print(response['employee']);
        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          if (response['success'] == true) {
            var employee = EmployeeModel.fromJson(response['employee']);
            // pour enregistrer le userAuthentifié dans shared preferences
            myServices.sharedPreferences.setString("id", employee.id.toString());
            myServices.sharedPreferences.setString("firstname", employee.firstname);
            myServices.sharedPreferences.setString("lastname", employee.lastname);
            myServices.sharedPreferences.setString("email", employee.email);

            // lehna bch k yabda l user c deja connecté w 3awed dkhal lel application direct yhezo lel home page ( middleware) kif fazet l onboarding
            myServices.sharedPreferences.setString("step", "2");

            // se deriger vers Home page
            Get.offNamed(AppRoutes.homeScreen);
          } else {
            Get.defaultDialog(title: "Echec", middleText: "Echec de connexion");
            statusRequest = StatusRequest.failure;
          }
        }
      } else {
        // Handle error response which is not a Map
        Get.defaultDialog(title: "Error".tr, middleText: "Server error or no response".tr);
        statusRequest = StatusRequest.failure;
      }
      
      update();
    } else {
      print("not valid");
    }
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
