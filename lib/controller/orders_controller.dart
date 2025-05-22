import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/ordersData.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';

class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;

  var selectedState = 0.obs;

  var sortAscending = true.obs;

  late OrdersData ordersData;

  @override
  void onInit() {
    super.onInit();
    ordersData = OrdersData(Crud());
    fetchOrders();
  }

  void fetchOrders() async {
    print("OrderController: Fetching orders from API");
    var data = await ordersData.getData();
    print("OrderController: Number of orders fetched: ${data.length}");
    orders.assignAll(data);
  }

  void updateFilterState(int state) {
    print("OrderController: Updating filter state to $state");
    selectedState.value = state;
  }

  void updateSortOrder(bool ascending) {
    print("OrderController: Updating sort order to ${ascending ? 'ascending' : 'descending'}");
    sortAscending.value = ascending;
  }

  List<OrderModel> get filteredSortedOrders {
    print("OrderController: Filtering and sorting orders");
    List<OrderModel> filtered =
        selectedState.value == 0
            ? orders
            : orders
                .where((order) => order.currentStateName == _getStatusFromState(selectedState.value))
                .toList();

    filtered.sort((a, b) {
      DateTime dateA = DateTime.tryParse(a.dateAdd) ?? DateTime(1970);
      DateTime dateB = DateTime.tryParse(b.dateAdd) ?? DateTime(1970);
      return sortAscending.value
          ? dateA.compareTo(dateB)
          : dateB.compareTo(dateA);
    });

    print("OrderController: Number of orders after filtering: ${filtered.length}");
    return filtered;
  }

  String _getStatusFromState(int currentState) {
    switch (currentState) {
      case 1:
        return 'En attente du paiement par chèque';
      case 2:
        return 'Paiement accepté';
      case 3:
        return 'En cours de préparation';
      case 4:
        return 'Expédié';
      case 5:
        return 'Livré';
      case 6:
        return 'Annulé';
      case 7:
        return 'Remboursé';
      case 8:
        return 'Erreur de paiement';
      case 9:
        return 'En attente de réapprovisionnement (payé)';
      case 10:
        return 'En attente de virement bancaire';
      case 11:
        return 'Paiement à distance accepté';
      case 12:
        return 'En attente de réapprovisionnement (non payé)';
      case 13:
        return 'En attente de paiement à la livraison';
      default:
        return 'Unknown';
    }
  }
}
