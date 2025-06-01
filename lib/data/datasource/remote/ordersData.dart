import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/order_model.dart';

class OrdersData {
  Crud crud;
  OrdersData(this.crud);

  Future<List<OrderModel>> getData() async {
    var response = await crud.getData(LinkApi.orders);
    return response.fold((l) {
      return [];
    }, (r) {
      if (r['success'] == true) {
        List ordersJson = r['orders'] ?? [];
        return ordersJson.map((orderJson) => OrderModel.fromJson(orderJson)).toList();
      } else {
        return [];
      }
    });
  }
}
