import 'package:endyear_2025_gr01_mobileapp/controller/ordersdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommandsDetailsPage extends StatelessWidget {
  const CommandsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersDetailsController controller = Get.find();

    final order = controller.order;

    String getStatus(int? currentState) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de commande'),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reference: ${order.reference}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),

                  const SizedBox(height: 8),
                  Text(
                    'Date Added: ${order.dateAdd?.toString() ?? 'N/A'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Payment Method: ${order.payment ?? 'N/A'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${getStatus(order.currentState)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),

                  const SizedBox(height: 8),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
