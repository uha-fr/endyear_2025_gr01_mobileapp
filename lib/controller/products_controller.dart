import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/productsData.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:get/get.dart';
 
abstract class ProductController extends GetxController {
  intialData();
  changeCat(int val, String catval); // changer l categorie l dkhalnelha
  getproduct();
  gotToPageProductDetails(ProductModel productModel);
}

class ProductControllerImp extends ProductController {
  List categories = [];
  String? catid;
  int? selectedCat;

  late Crud crud = Crud();
  late ProductsData productsData = ProductsData(crud);

  List data = [];
  List filteredData = [];

  late StatusRequest statusRequest;

  //MyServices myServices = Get.find();

  String deliveryTime = "";

  String? selectedCategoryId;
  String stockFilter = "all"; // all, in_stock, out_of_stock

  @override
  void onInit() {
    intialData();
    super.onInit();
  }

  @override
  intialData() {
    getproduct();
  }

  void updateCategoryFilter(String? categoryId) {
    selectedCategoryId = categoryId;
    applyFilters();
  }

  void updateStockFilter(String filter) {
    stockFilter = filter;
    applyFilters();
  }

  void applyFilters() {
    filteredData = data.where((product) {
      bool matchesCategory = selectedCategoryId == null || selectedCategoryId == "" || product.categoriesId == selectedCategoryId;
      bool matchesStock = true;
      int count = int.tryParse(product.productCount ?? '0') ?? 0;
      if (stockFilter == "in_stock") {
        matchesStock = count > 0;
      } else if (stockFilter == "out_of_stock") {
        matchesStock = count == 0;
      }
      return matchesCategory && matchesStock;
    }).toList();
    update();
  }

  @override
  changeCat(val, catval) {
    selectedCategoryId = catval;
    getproduct();
    update();
  }

  @override
  getproduct() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await productsData.getData();
    print('Fetched product data: $response'); // Added print for debugging
    if (response.isNotEmpty) {
      data = response.map((e) => ProductModel.fromJson(e)).toList();
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
