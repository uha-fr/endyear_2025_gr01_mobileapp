import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order.dart';
import 'package:get/get.dart';

class OrdersDetailsController extends GetxController {
  late OrderModel order;

  void setOrder(OrderModel selectedOrder) {
    order = selectedOrder;
  }
}
