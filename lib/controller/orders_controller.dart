import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/static/orders.dart';

class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() {
    orders.assignAll(ordersList);
  }
}
