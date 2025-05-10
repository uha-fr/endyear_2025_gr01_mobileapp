import 'package:endyear_2025_gr01_mobileapp/controller/orders_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/orders/customordercard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommandesPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  CommandesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commandes'),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return CustomOrderCard(
              orderId: order.id.toString(),
              customerName: order.reference ?? 'No Name',
              date: order.dateAdd?.toString() ?? 'N/A',
              amount: order.totalPaid ?? 0.0,
              status: _getStatusFromState(order.currentState),
            );
          },
        );
      }),
    );
  }

  String _getStatusFromState(int? currentState) {
    switch (currentState) {
      case 1:
        return 'Processing';
      case 2:
        return 'Shipped';
      case 3:
        return 'Pending';
      case 4:
        return 'Delivered';
      case 5:
        return 'Canceled';
      default:
        return 'Unknown';
    }
  }
}
