import 'package:endyear_2025_gr01_mobileapp/controller/auth/login_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/products_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/handlingdataview.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/products/customlistproducts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductControllerImp controller = Get.put(ProductControllerImp());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 70,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: const Text(
                'Produits',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor,
                      AppColor.primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    final loginController = Get.find<LoginControllerImp>();
                    loginController.logout();
                  },
                  icon: const Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: GetBuilder<ProductControllerImp>(
                builder:
                    (controller) => HandlingDataView(
                      statusRequest: controller.statusRequest,
                      widget: Column(
                        children: [
                          const SizedBox(height: 20),
                          // Filters UI
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<int?>(
                                value: controller.selectedCategoryId,
                                hint: const Text('Sélectionner une catégorie'),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('Toutes les catégories'),
                                  ),
                                  ...controller.categories
                                      .map<DropdownMenuItem<int?>>((cat) {
                                        return DropdownMenuItem<int?>(
                                          value: cat['id'] as int?,
                                          child: Text(cat['name'].toString()),
                                        );
                                      })
                                      .toList(),
                                ],
                                onChanged: (value) {
                                  controller.updateCategoryFilter(value);
                                },
                              ),
                              DropdownButton<String>(
                                value: controller.stockFilter,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'all',
                                    child: Text('Tous les produits'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'in_stock',
                                    child: Text('En Stock'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'out_of_stock',
                                    child: Text('Rupture de stock'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.updateStockFilter(value);
                                  }
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<String>(
                                value: controller.alphabeticalOrder,
                                hint: const Text('Trier par nom'),
                                items: const [
                                  DropdownMenuItem(
                                    value: null,
                                    child: Text('Ordre Alphabétique'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'asc',
                                    child: Text('A-Z'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'desc',
                                    child: Text('Z-A'),
                                  ),
                                ],
                                onChanged: (value) {
                                  controller.updateAlphabeticalOrder(value);
                                },
                              ),
                            ],
                          ),
                          // Afficher les produits
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.filteredData.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (MediaQuery.of(context).size.width ~/ 200)
                                          .clamp(1, 6),
                                  childAspectRatio: 0.7,
                                ),
                            itemBuilder: (BuildContext context, index) {
                              return CustomListproduct(
                                productModel: controller.filteredData[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
