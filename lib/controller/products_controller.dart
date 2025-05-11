import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/model/productmodel/productmodel.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/products_controller.dart';
import 'package:get/get.dart';
 
abstract class ProductController extends GetxController {
  intialData();
  changeCat(int val, String catval); // changer l categorie l dkhalnelha
  getproduct(String categoryid);
  gotToPageProductDetails(ProductModel productModel);
}

class ProductControllerImp extends ProductController {
  List categories = [];
  String? catid;
  int? selectedCat;

  late ProductsData productsData =  ProductsData();

  List data = [];

  late StatusRequest statusRequest;

  //MyServices myServices = Get.find();

  String deliveryTime="";

  @override
  void onInit() {
    intialData();
    super.onInit();
  }

  @override
  intialData() {
    //categories = Get.arguments['categories'];
    //selectedCat = Get.arguments['selectedcat'];
    //catid = Get.arguments['catid'];
    
    getproduct("1");
  }

  @override
  changeCat(val, catval) {
    selectedCat = val;
    catid = catval;
    getproduct(catid!);
    update();
  }

  @override
  getproduct(categoryid) async {
    data = [
      ProductModel(
        productId: "1",
        productName: "Product 1",
        productDesc: "Description for product 1",
        productImage: "product1.png",
        productCount: "10",
        productActive: "1",
        productPrice: "100",
        productDate: "2023-01-01",
        productCat: "cat1",
        categoriesId: "cat1",
        categoriesName: "Category 1",
        categoriesImage: "cat1.png",
        categoriesDatetime: "2023-01-01",
      ),
      ProductModel(
        productId: "2",
        productName: "Product 2",
        productDesc: "Description for product 2",
        productImage: "product2.png",
        productCount: "0",
        productActive: "1",
        productPrice: "200",
        productDate: "2023-01-02",
        productCat: "cat2",
        categoriesId: "cat2",
        categoriesName: "Category 2",
        categoriesImage: "cat2.png",
        categoriesDatetime: "2023-01-02",
      ),
       ProductModel(
        productId: "3",
        productName: "Product 3",
        productDesc: "Description for product 3",
        productImage: "product3.png",
        productCount: "5",
        productActive: "1",
        productPrice: "300",
        productDate: "2023-01-03",
        productCat: "cat2",
        categoriesId: "cat2",
        categoriesName: "Category 2",
        categoriesImage: "cat2.png",
        categoriesDatetime: "2023-01-02",
      ),
       ProductModel(
        productId: "4",
        productName: "Product 4",
        productDesc: "Description for product 4",
        productImage: "product4.png",
        productCount: "5",
        productActive: "1",
        productPrice: "200",
        productDate: "2023-01-02",
        productCat: "cat2",
        categoriesId: "cat2",
        categoriesName: "Category 2",
        categoriesImage: "cat2.png",
        categoriesDatetime: "2023-01-02",
      ),
    ];
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  gotToPageProductDetails(productModel) {
    Get.toNamed("productdetails", arguments: {"productModel": productModel});
  }
}
