import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/productsData.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
abstract class ProductController extends GetxController {
  intialData();
  changeCat(int val, String catval); // changer l categorie l dkhalnelha
  getproduct();
  gotToPageProductDetails(ProductModel productModel);
}

class ProductControllerImp extends ProductController {
  List<Map<String, dynamic>> categories = [];

  String? catid;
  int? selectedCat;

  late Crud crud = Crud();
  late ProductsData productsData = ProductsData(crud);

  List data = [];
  List filteredData = [];

  late StatusRequest statusRequest;

  //MyServices myServices = Get.find();

  String deliveryTime = "";

  int? selectedCategoryId;
  String stockFilter = "all"; // all, in_stock, out_of_stock

  String? alphabeticalOrder; // 'asc' or 'desc' or null

  @override
  void onInit() {
    intialData();
    super.onInit();
  }

  @override
  intialData() {
    getproduct();
  }

  void updateCategoryFilter(int? categoryId) {
    selectedCategoryId = categoryId;
    applyFilters();
  }

  void updateStockFilter(String filter) {
    stockFilter = filter;
    applyFilters();
  }

  void updateAlphabeticalOrder(String? order) {
    alphabeticalOrder = order;
    applyFilters();
  }

  void applyFilters() {
    filteredData = data.where((product) {
      bool matchesCategory = selectedCategoryId == null || product.categoriesId == selectedCategoryId;
      bool matchesStock = true;
      int count = product.productCount ?? 0;
      if (stockFilter == "in_stock") {
        matchesStock = count > 0;
      } else if (stockFilter == "out_of_stock") {
        matchesStock = count == 0;
      }
      return matchesCategory && matchesStock;
    }).toList();

    if (alphabeticalOrder != null) {
      filteredData.sort((a, b) {
        String nameA = a.productName?.toLowerCase() ?? '';
        String nameB = b.productName?.toLowerCase() ?? '';
        if (alphabeticalOrder == 'asc') {
          return nameA.compareTo(nameB);
        } else {
          return nameB.compareTo(nameA);
        }
      });
    }

    update();
  }

  @override
  changeCat(int val, String catval) {
    selectedCategoryId = val;
    getproduct();
    update();
  }




  @override
getproduct() async {
  statusRequest = StatusRequest.loading;
  update();
  var response = await productsData.getData();
  print('Fetched product data: $response'); // Debug
  if (response.isNotEmpty) {
    data = response.map((e) => ProductModel.fromJson(e)).toList();

    // Extraire les catégories uniques depuis les produits
    final uniqueCategories = {
      for (var product in data)
        if (product.categoriesId != null)
          product.categoriesId!: product.categoriesName ?? 'Catégorie inconnue'
    };

    categories = uniqueCategories.entries
        .map((e) => {'id': e.key, 'name': e.value})
        .toList();

    statusRequest = StatusRequest.success;
  } else {
    statusRequest = StatusRequest.failure;
  }
  applyFilters();
}


  @override
  gotToPageProductDetails(productModel) {
    Get.toNamed("productdetails", arguments: {"productModel": productModel});
  }

 
}
