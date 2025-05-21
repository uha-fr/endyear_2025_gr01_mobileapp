import 'package:endyear_2025_gr01_mobileapp/controller/products_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/handlingdataview.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/customappbarSearch.dart';
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

          //1ér partie customAppBar ( recherche et button notif )
          CustomAppBarSearsh(
            mycontroller: TextEditingController(),
            onChanged: (val) {

            },
            title: "Nom du produit",
            onPressedIcon: () {},
            onPressedSearch: () {

            },

          ),

          const SizedBox(height: 20),

          // 2ém partie (Filters + ListProducts)
          GetBuilder<ProductControllerImp>(
            builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Column(
                children: [
                  // Filters UI
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<int?>(
  value: controller.selectedCategoryId,
  hint: const Text('Sélectionner une catégorie'),
  items: [
     DropdownMenuItem(value: null, child: Text('Toutes les catégories')),

    ...controller.categories.map<DropdownMenuItem<int?>>((cat) {
  return DropdownMenuItem<int?>(
    value: cat['id'] as int?,  
    child: Text(cat['name'].toString()),  
  );
}).toList(),

  ],
  onChanged: (value) {
    controller.updateCategoryFilter(value);
  },
),

                      DropdownButton<String>(
                        value: controller.stockFilter,
                        items: [
                          DropdownMenuItem(value: 'all', child: Text('Tous les produits')),
                          DropdownMenuItem(value: 'in_stock', child: Text('En Stock')),
                          DropdownMenuItem(value: 'out_of_stock', child: Text('Rupture de stock')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateStockFilter(value);
                          }
                        },
                      ),
                    ],
                  ),
                  // Afficher les produits
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredData.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.7),
                    itemBuilder: (BuildContext context, index) {
                      return CustomListproduct(productModel: controller.filteredData[index]);
                    },
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
