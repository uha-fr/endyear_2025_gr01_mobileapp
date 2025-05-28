import 'package:endyear_2025_gr01_mobileapp/controller/auth/login_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/tasks_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/tasks/customlistorder.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/tasks/customlistproduct.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    TasksControllerImp controller = Get.put(TasksControllerImp());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text(
            'Tâches à faire',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0, // Optionnel : enlève l’ombre
          actions: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 60,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: IconButton(
                onPressed: () {
                  final loginController = Get.find<LoginControllerImp>();
                  loginController.logout();
                },
                icon: const Icon(
                  Icons.exit_to_app_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // TabBar avec fond blanc
            Container(
              color: Colors.white,
              child: const TabBar(
                tabs: [
                  Tab(text: 'Commandes à traiter'),
                  Tab(text: 'Commandes à expédier'),
                  Tab(text: 'Réapprovisionnement'),
                ],
                indicatorColor: AppColor.primaryColor,
                labelColor: AppColor.primaryColor,
                unselectedLabelColor: Colors.black54,
              ),
            ),
            // Le contenu selon le tab sélectionné
            Expanded(
              child: TabBarView(
                children: [
                  GetBuilder<TasksControllerImp>(
                    builder: (controller) {
                      final ordersToProcess = controller.ordersToProcess;
                      return ListView.builder(
                        itemCount: ordersToProcess.length,
                        itemBuilder: (context, index) {
                          final order = ordersToProcess[index];
                          return CustomListOrder(order: order);
                        },
                      );
                    },
                  ),
                  GetBuilder<TasksControllerImp>(
                    builder: (controller) {
                      final ordersToShip = controller.ordersToShip;
                      return ListView.builder(
                        itemCount: ordersToShip.length,
                        itemBuilder: (context, index) {
                          final order = ordersToShip[index];
                          return CustomListOrder(order: order);
                        },
                      );
                    },
                  ),
                  GetBuilder<TasksControllerImp>(
                    builder: (controller) {
                      final restockProducts = controller.restockProducts;
                      return ListView.builder(
                        itemCount: restockProducts.length,
                        itemBuilder: (context, index) {
                          final product = restockProducts[index];
                          return CustomListProduct(product: product);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
