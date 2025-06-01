import 'package:dartz/dartz.dart';
import 'package:endyear_2025_gr01_mobileapp/bindings/initbindings.dart';
import 'package:endyear_2025_gr01_mobileapp/core/services/services.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/auth/login.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/routes.dart';

Future<void> main() async {
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GestionMagasin',
      home: const Login(),
      initialBinding: InitialBindings(), // linjecté le crud
      getPages: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
