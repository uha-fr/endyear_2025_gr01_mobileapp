import 'package:endyear_2025_gr01_mobileapp/controller/orderdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/ordersData.dart';
import 'package:get/get.dart';

abstract class TasksController extends GetxController {
  intialData();
  getOrdersToProcess();
  getOrdersToShip();
  getRestockProducts();
  goToPageOrderDetails(OrderModel order);
  gotToPageProductDetails(ProductModel productModel);
}

class TasksControllerImp extends TasksController {
  List<OrderModel> orders = [];
  List<OrderModel> ordersToProcess = [];
  List<OrderModel> ordersToShip = [];
  List<ProductModel> products = [];
  List<ProductModel> restockProducts = [];

  late StatusRequest statusRequest;
  late OrdersData ordersData;

  @override
  void onInit() {
    ordersData = OrdersData(Crud());
    intialData();
    super.onInit();
  }

  @override
  intialData() {
    fetchOrders();

  }

  void fetchOrders() async {
    var fetchedOrders = await ordersData.getData();
    orders.assignAll(fetchedOrders);
    getOrdersToProcess();
    getOrdersToShip();
    getRestockProducts();
  }

  @override
  getOrdersToProcess() {
    ordersToProcess = orders.where((order) => order.currentStateName == "Paiement accepté").toList();
    update();
  }

  @override
  getOrdersToShip() {
    ordersToShip = orders.where((order) => order.currentStateName == "En cours de préparation").toList();
    update();
  }

  @override
  getRestockProducts() {
    // Mock products with productCount < 10
    products = [];
    restockProducts = products.where((product) {
      //int count = int.tryParse(product.productCount ?? "0") ?? 0;
      return true;
    }).toList();
    update();
  }

  @override
  goToPageOrderDetails(OrderModel order) {
    final OrdersDetailsController detailsController = Get.put(OrdersDetailsController());
    detailsController.setOrder(order);
    Get.toNamed('/orderdetails');
  }

  @override
  gotToPageProductDetails(productModel) {
    Get.toNamed("productdetails", arguments: {"productModel": productModel});
  }
}
