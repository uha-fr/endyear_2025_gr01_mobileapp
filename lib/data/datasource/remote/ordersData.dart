import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/order_model.dart';

class OrdersData {
  Crud crud;
  OrdersData(this.crud);

  Future<List<OrderModel>> getData() async {
    print("OrdersData: Starting getData call to API");
    var response = await crud.getData(LinkApi.orders);
    print("OrdersData: Received response from API");
    return response.fold((l) {
      print("OrdersData: Error in API call: \$l");
      return [];
    }, (r) {
      if (r['success'] == true) {
        print("OrdersData: API call success true");
        List ordersJson = r['orders'] ?? [];
        print("OrdersData: Number of orders received: ${ordersJson.length}");
        return ordersJson.map((orderJson) => OrderModel.fromJson(orderJson)).toList();
      } else {
        print("OrdersData: API call success false");
        return [];
      }
    });
  }
}
