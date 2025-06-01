import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:endyear_2025_gr01_mobileapp/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

class MyMiddleWare extends GetMiddleware {
  int? get priority => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {

    // if user is already authenticated -> go to homePage
    if (myServices.sharedPreferences.getString("step") == "2") {
      return const RouteSettings(name: AppRoutes.homePage);
    }

    // if back office URL is set -> go to login page
    String? serverUrl = myServices.sharedPreferences.getString('server_url');
    if (serverUrl != null && serverUrl.isNotEmpty) {
      return const RouteSettings(name: AppRoutes.login);
    }

    // else go to config page to enter back office URL
    return const RouteSettings(name: AppRoutes.configPage);
  }
}
