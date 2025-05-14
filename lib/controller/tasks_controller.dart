import 'package:endyear_2025_gr01_mobileapp/controller/ordersdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
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

  @override
  void onInit() {
    intialData();
    super.onInit();
  }

  @override
  intialData() {
    getOrdersToProcess();
    getOrdersToShip();
    getRestockProducts();
  }

  @override
  getOrdersToProcess() {
    // Mock orders with payment accepted
    orders = [
      OrderModel(
        id: 1,
        reference: "#12345",
        customerName: "John Doe",
        payment: "accepted",
        currentState: 1,
        totalProducts: 3,
      ),
      OrderModel(
        id: 2,
        reference: "#12342",
        customerName: "Sarah Williams",
        payment: "accepted",
        currentState: 1,
        totalProducts: 1,
      ),
    ];
    ordersToProcess = orders.where((order) => order.payment == "accepted").toList();
    update();
  }

  @override
  getOrdersToShip() {
    // Mock orders with status "prepared" (currentState == 2)
    orders = [
      OrderModel(
        id: 3,
        reference: "#12340",
        customerName: "Robert Jones",
        payment: "accepted",
        currentState: 2,
        totalProducts: 2,
      ),
    ];
    ordersToShip = orders.where((order) => order.currentState == 2).toList();
    update();
  }

  @override
  getRestockProducts() {
    // Mock products with productCount < 10
    products = [
      ProductModel(
        productId: "p1",
        productName: "Premium T-Shirt",
        productCount: "2",
      ),
      ProductModel(
        productId: "p2",
        productName: "Denim Jeans",
        productCount: "3",
      ),
      ProductModel(
        productId: "p3",
        productName: "Leather Bag",
        productCount: "0",
      ),
    ];
    restockProducts = products.where((product) {
      int count = int.tryParse(product.productCount ?? "0") ?? 0;
      return count < 10;
    }).toList();
    update();
  }

  @override
  goToPageOrderDetails(OrderModel order) {
     final OrdersDetailsController detailsController = Get.put(OrdersDetailsController());
    detailsController.setOrder(order);
    Get.toNamed('/commandsdetails');
  }

   @override
  gotToPageProductDetails(productModel) {
    Get.toNamed("productdetails", arguments: {"productModel": productModel});
  }
}
