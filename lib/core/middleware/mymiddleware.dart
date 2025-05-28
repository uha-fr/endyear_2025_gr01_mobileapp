import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:endyear_2025_gr01_mobileapp/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

class MyMiddleWare extends GetMiddleware {
  int? get priority => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {

   //if l utilisateur est deja connecté -> vers pageHome
    if (myServices.sharedPreferences.getString("step") == "2") {
      return const RouteSettings(name: AppRoutes.homePage);
    }

     else {
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
