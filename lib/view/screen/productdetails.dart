import 'package:endyear_2025_gr01_mobileapp/controller/productdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/handlingdataview.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/customAppBar.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ProductDetailsControllerImp controller =
        Get.put(ProductDetailsControllerImp());
    return Scaffold(
        appBar: CustomAppBar(title: "détails de produit"),
        body: GetBuilder<ProductDetailsControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: ListView(
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
                                if (controller.productModel.productImage != null && controller.productModel.productImage!.isNotEmpty)
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        controller.productModel.productImage!,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                Text(
                                  "${controller.productModel.productName}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        color: AppColor.fourthColor,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${controller.productModel.productDesc}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 20),
                                Text("Product ID: ${controller.productModel.productId ?? 'N/A'}"),
                                const SizedBox(height: 5),
                                Text("Count: ${controller.productModel.productCount ?? 'N/A'}"),
                                const SizedBox(height: 5),
                                Text("Active: ${controller.productModel.productActive ?? 'N/A'}"),
                                const SizedBox(height: 5),
                                Text("Price: ${controller.productModel.productPrice ?? 'N/A'}"),
                                const SizedBox(height: 5),
                                Text("Date: ${controller.productModel.productDate ?? 'N/A'}"),
                                const SizedBox(height: 5),
                                Text("Category: ${controller.productModel.productCat ?? 'N/A'}"),
                                const SizedBox(height: 20),
                                Text("Category ID: ${controller.productModel.categoriesId ?? 'N/A'}"),
                                const SizedBox(height: 5),
                                Text("Category Name: ${controller.productModel.categoriesName ?? 'N/A'}"),
                                const SizedBox(height: 5),
                                if (controller.productModel.categoriesImage != null && controller.productModel.categoriesImage!.isNotEmpty)
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        controller.productModel.categoriesImage!,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 5),
                                Text("Category Date: ${controller.productModel.categoriesDatetime ?? 'N/A'}"),
                                const SizedBox(height: 10),
                              ]),
                        ),
                      )
                    ],
                  ),
                )));
  }
}
