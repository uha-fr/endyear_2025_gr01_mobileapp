import 'package:cached_network_image/cached_network_image.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/color.dart';
import '../../../linkapi.dart';
import 'dart:convert';


class CustomListproduct extends GetView<ProductControllerImp> {
  final ProductModel productModel;
//  final bool active;
  const CustomListproduct({super.key, required this.productModel});

bool isBase64(String str) {
    try {
      String base64Str = str;
      if (str.startsWith('data:image')) {
        base64Str = str.substring(str.indexOf(',') + 1);
      }
      final decoded = base64Decode(base64Str);
      return decoded.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

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
                child: SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Hero(
                        tag: "${productModel.productId}",
                        child: isBase64(productModel.productImage ?? '')
                      ? Image.memory(
                                base64Decode(
                                  (productModel.productImage ?? '').startsWith('data:image')
                                  ? (productModel.productImage ?? '').substring((productModel.productImage ?? '').indexOf(',') + 1)
                                  : (productModel.productImage ?? '')
                                ),
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                productModel.productImage ?? '',
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
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
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        margin: const EdgeInsets.only(bottom: 4),
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
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    ]),
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
