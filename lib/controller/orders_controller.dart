import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/static/orders_data.dart';

class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;

  var selectedState = 0.obs;

  var sortAscending = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() {
    orders.assignAll(ordersList);
  }

  void updateFilterState(int state) {
    selectedState.value = state;
  }

  void updateSortOrder(bool ascending) {
    sortAscending.value = ascending;
  }

  List<OrderModel> get filteredSortedOrders {
    List<OrderModel> filtered =
        selectedState.value == 0
            ? orders
            : orders
                .where((order) => order.currentState == selectedState.value)
                .toList();

    filtered.sort((a, b) {
      DateTime dateA = a.dateAdd ?? DateTime(1970);
      DateTime dateB = b.dateAdd ?? DateTime(1970);
      return sortAscending.value
          ? dateA.compareTo(dateB)
          : dateB.compareTo(dateA);
    });

    return filtered;
  }
}
