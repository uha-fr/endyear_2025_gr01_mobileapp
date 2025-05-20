import 'package:cached_network_image/cached_network_image.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/color.dart';
import '../../../linkapi.dart';


class CustomListproduct extends GetView<ProductControllerImp> {
  final ProductModel productModel;
//  final bool active;
  const CustomListproduct({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          controller.gotToPageProductDetails(productModel);
        },
        child: Card(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "${productModel.productId}",
                        child: CachedNetworkImage(
                          imageUrl:
                          "${productModel.productImage ?? ''}",
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(productModel.productName ?? '',
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),

                      const SizedBox(height: 4),

                      Text(
                        "Catégorie: ${productModel.categoriesName ?? ''}",
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const SizedBox(height: 4),

                      Text(
                        "Date: ${productModel.productDate ?? ''}",
                        style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 14,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // prix du produit 
                          Text("${productModel.productPrice ?? 0} \$",
                              style: const TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "sans")),

                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: (productModel.productCount ?? 0) > 0
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (productModel.productCount ?? 0) > 0
                              ? "En Stock ${productModel.productCount}"
                              : "Rupture de stock 0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    ]),
              ),

            ],
          ),
        ));
  }
}
