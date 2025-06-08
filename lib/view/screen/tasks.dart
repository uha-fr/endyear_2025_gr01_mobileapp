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
        body: CustomScrollView(
          slivers: [
            // Top AppBar
            SliverAppBar(
              expandedHeight: 70,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: const Text(
                  'Tâches à faire',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.primaryColor,
                        AppColor.primaryColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      final loginController = Get.find<LoginControllerImp>();
                      loginController.logout();
                    },
                    icon: const Icon(
                      Icons.exit_to_app_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),

            // TabBar
            SliverToBoxAdapter(
              child: Container(
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
            ),

            // TabBarView Content
            SliverFillRemaining(
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
