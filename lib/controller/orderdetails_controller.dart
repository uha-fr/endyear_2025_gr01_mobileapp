import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/orderDetailsData.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';

class OrdersDetailsController extends GetxController {
  var order = Rxn<OrderModel>();

  late OrderDetailsData orderDetailsData;

  @override
  void onInit() {
    super.onInit();
    print('OrdersDetailsController: onInit called');
    orderDetailsData = OrderDetailsData(Crud());

    // Fetch order details if id is passed as argument
    var id = Get.arguments;
    if (id != null && id is int) {
      print('OrdersDetailsController: onInit fetching order details for id: $id');
      fetchOrderDetails(id);
    }
  }

  void setOrder(OrderModel selectedOrder) {
    print('OrdersDetailsController: setOrder called with id: ${selectedOrder.id}');
    print('OrdersDetailsController: deliveryAddress: address1=${selectedOrder.deliveryAddress.address1}, address2=${selectedOrder.deliveryAddress.address2}, city=${selectedOrder.deliveryAddress.city}, postcode=${selectedOrder.deliveryAddress.postcode}, country=${selectedOrder.deliveryAddress.country}');
    print('OrdersDetailsController: invoiceAddress: address1=${selectedOrder.invoiceAddress.address1}, address2=${selectedOrder.invoiceAddress.address2}, city=${selectedOrder.invoiceAddress.city}, postcode=${selectedOrder.invoiceAddress.postcode}, country=${selectedOrder.invoiceAddress.country}');
    order.value = selectedOrder;
  }

  Future<void> fetchOrderDetails(int id) async {
    print('OrdersDetailsController: fetchOrderDetails called with id: $id');
    var data = await orderDetailsData.getData(id);
    if (data != null) {
      print('OrdersDetailsController: fetchOrderDetails received data for id: $id');
      order.value = data;
    } else {
      print('OrdersDetailsController: fetchOrderDetails received null data for id: $id');
    }
  }
}
