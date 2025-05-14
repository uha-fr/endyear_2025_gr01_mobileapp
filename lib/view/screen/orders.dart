import 'package:endyear_2025_gr01_mobileapp/controller/orders_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/orderdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/clients_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/orders/customordercard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommandesPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  final ClientsController clientsController = Get.put(ClientsController());

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filtrer par état
                Obx(
                  () => DropdownButton<int>(
                    isDense: true,
                    value: orderController.selectedState.value,
                    items: [
                      const DropdownMenuItem(value: 0, child: Text('All')),
                      const DropdownMenuItem(
                        value: 1,
                        child: Text('Processing'),
                      ),
                      const DropdownMenuItem(value: 2, child: Text('Shipped')),
                      const DropdownMenuItem(value: 3, child: Text('Pending')),
                      const DropdownMenuItem(
                        value: 4,
                        child: Text('Delivered'),
                      ),
                      const DropdownMenuItem(value: 5, child: Text('Canceled')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        orderController.updateFilterState(value);
                      }
                    },
                  ),
                ),
                // Trier par date
                Obx(
                  () => DropdownButton<bool>(
                    isDense: true,
                    value: orderController.sortAscending.value,
                    items: const [
                      DropdownMenuItem(value: true, child: Text('Date Asc')),
                      DropdownMenuItem(value: false, child: Text('Date Desc')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        orderController.updateSortOrder(value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (orderController.orders.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final filteredOrders = orderController.filteredSortedOrders;
              if (filteredOrders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }
              return ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  final client = clientsController.clientsList.firstWhereOrNull(
                    (c) => c.id == order.idCustomer,
                  );
                  final clientName =
                      client != null
                          ? '${client.firstname} ${client.lastname}'
                          : 'No Name';
                  return GestureDetector(
                    onTap: () {
                      final OrdersDetailsController detailsController = Get.put(
                        OrdersDetailsController(),
                      );
                      detailsController.setOrder(order);
                      Get.toNamed('/commandsdetails');
                    },
                    child: CustomOrderCard(
                      orderId: order.reference.toString(),
                      customerName: clientName,
                      date: order.dateAdd?.toString() ?? 'N/A',
                      amount: order.totalPaid ?? 0.0,
                      status: _getStatusFromState(order.currentState),
                    ),
                  );
                },
              );
            }),
          ),
        ],
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
      default:
        return 'Unknown';
    }
  }
}
