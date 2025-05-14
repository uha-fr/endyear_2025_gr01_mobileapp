import 'package:endyear_2025_gr01_mobileapp/controller/tasks_controller.dart';
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
          title: const Text('Tâches'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Commandes à traiter'),
              Tab(text: 'Commandes à expédier'),
              Tab(text: 'Réapprovisionnement'),
            ],
          ),
        ),
        body: TabBarView(
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
    );
  }
}
