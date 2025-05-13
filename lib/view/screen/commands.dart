import 'package:endyear_2025_gr01_mobileapp/controller/orders_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/ordersdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/orders/customordercard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (orderController.orders.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }

        final displayOrders = orderController.orders.toList();

        return ListView.builder(
          itemCount: displayOrders.length,
          itemBuilder: (context, index) {
            final order = displayOrders[index];

            // Format the date
            String formattedDate = 'N/A';
            try {
              if (order.dateAdd.isNotEmpty) {
                final dateTime = DateTime.parse(order.dateAdd);
                formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
              }
            } catch (e) {
              print('Error formatting date: $e');
            }

            return GestureDetector(
              onTap: () {
                final OrdersDetailsController detailsController = Get.put(
                  OrdersDetailsController(),
                );
                detailsController.setOrder(order);
                Get.toNamed('/commandsdetails');
              },
              child: CustomOrderCard(
                orderId: order.reference,
                customerName: order.customerName ?? 'No Name',
                date: formattedDate,
                amount: order.totalPaidTaxIncl ?? 0.0,
                status: _getStatusFromState(order.currentState),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => orderController.fetchOrders(),
        backgroundColor: AppColor.primaryColor,
        child: const Icon(Icons.refresh),
      ),
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
      case 6:
        return 'Paid';
      default:
        return 'Unknown';
    }
  }
}
