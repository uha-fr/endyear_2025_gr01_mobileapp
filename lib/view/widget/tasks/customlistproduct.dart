import 'package:flutter/material.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/tasks_controller.dart';
import 'package:get/get.dart';

class CustomListProduct extends GetView<TasksControllerImp> {
  final ProductModel product;

  const CustomListProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text(product.productName ?? ''),
        subtitle: Text('Stock: ${product.productCount ?? '0'}'),
        onTap: () {
          controller.gotToPageProductDetails(product);
        },
      ),
    );
  }
}
