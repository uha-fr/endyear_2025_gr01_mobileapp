import 'package:endyear_2025_gr01_mobileapp/controller/products_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/handlingdataview.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/customappbar.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/products/customlistproducts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
 Widget build(BuildContext context) {
    ProductControllerImp controller = Get.put(ProductControllerImp());
    

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [

          

          const SizedBox(height: 20),

          // 2ém partie (ListProducts)
          GetBuilder<ProductControllerImp>(
            builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemBuilder: (BuildContext context, index) {
                  return CustomListproduct(productModel: controller.data[index]);
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
