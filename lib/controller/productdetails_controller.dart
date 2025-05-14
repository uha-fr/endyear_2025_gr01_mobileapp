

import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:get/get.dart';

abstract class ProductDetailsController extends GetxController {
 
}

class ProductDetailsControllerImp extends ProductDetailsController {

  late ProductModel productModel;

  late StatusRequest statusRequest;


 @override
  void onInit() {
    intialData();
    super.onInit();
  }
  
  void intialData() {
    statusRequest = StatusRequest.loading;
    productModel=Get.arguments['productModel'];
    statusRequest = StatusRequest.success;
    update();
  }
  
}