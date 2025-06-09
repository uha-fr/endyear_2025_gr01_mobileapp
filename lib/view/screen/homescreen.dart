import 'dart:io';

import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/home/custombottomappbarhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/homescreen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());

    return GetBuilder<HomeScreenControllerImp>(
      builder:
          (controller) => Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.primaryColor,
              onPressed: () {
                controller.changePage(
                  0,
                ); // Switch to home page instead of navigating
              },
              child: const Icon(Icons.home),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const CustomBottomAppBarHome(),
            body: WillPopScope(
              child: controller.listPage.elementAt(controller.currentpage),
              onWillPop: () {
                Get.defaultDialog(
                  title: "Avertissement",
                  middleText: "Voulez vous quitter l'application ?",
                  titleStyle: const TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColor.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        exit(0);
                      },
                      child: Text("Confirmer"),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColor.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Annuler"),
                    ),
                  ],
                );
                return Future.value(false);
              },
            ),
          ),
    );
  }
}
