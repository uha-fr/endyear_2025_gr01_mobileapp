import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListOrder extends StatelessWidget {
  final OrderModel order;

  const CustomListOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to order details passing order id as argument, same as in orders.dart
        Get.toNamed('/orderdetails', arguments: order.id);
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              const Icon(Icons.receipt_long, size: 36, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${order.id}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      order.customerName,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      order.dateAdd,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${order.totalPaidTaxIncl.toStringAsFixed(2)} €",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.currentStateName,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
