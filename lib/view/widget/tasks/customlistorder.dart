/*
import 'package:flutter/material.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/tasks_controller.dart';
import 'package:get/get.dart';

class CustomListOrder extends GetView<TasksControllerImp> {
  final OrderModel order;

  const CustomListOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text(order.reference ?? ''),
        subtitle: Text('Client: ${order.customerName ?? ''}'),
        trailing: Text(
          'Articles: ${order.totalProducts?.toInt() ?? 0}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          controller.goToPageOrderDetails(order);
        },
      ),
    );
  }
}*/
