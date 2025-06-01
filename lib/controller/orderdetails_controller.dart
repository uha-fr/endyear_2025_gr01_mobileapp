import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/orderDetailsData.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';

import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/productsData.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';

class OrdersDetailsController extends GetxController {
  var order = Rxn<OrderModel>();

  late OrderDetailsData orderDetailsData;
  late ProductsData productsData;

  @override
  void onInit() {
    super.onInit();
    orderDetailsData = OrderDetailsData(Crud());
    productsData = ProductsData(Crud());

    // Fetch order details if id is passed as argument
    var id = Get.arguments;
    if (id != null && id is int) {
      fetchOrderDetails(id);
    }
  }

  void setOrder(OrderModel selectedOrder) {
    order.value = selectedOrder;
  }

  Future<void> fetchOrderDetails(int id) async {
    var data = await orderDetailsData.getData(id);
    if (data != null) {
      order.value = data;
    } else {
    }
  }

  Future<void> goToProductDetails(int productId) async {
    ProductModel? product = await productsData.getProductDetails(productId);
    if (product != null) {
      Get.toNamed('productdetails', arguments: {'productModel': product});
    } else {
      Get.snackbar('Erreur', 'Produit non trouvé');
    }
  }

  Future<bool> updateOrderStatus(int orderId, int newStateId) async {
    bool success = await orderDetailsData.updateOrderStatus(orderId, newStateId);
    if (success) {
      await fetchOrderDetails(orderId);
    } else {
    }
    return success;
  }
}
