import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/order_model.dart';

class OrderDetailsData {
  Crud crud;
  OrderDetailsData(this.crud);

  Future<OrderModel?> getData(int id) async {
var response = await crud.getData('${LinkApi.instance.orderDetails}?id=$id');
    return response.fold((l) => null, (r) {
      if (r['success'] == true) {
        var orderJson = r['order'];
        return OrderModel.fromJson(orderJson);
      } else {
        return null;
      }
    });
  }

  Future<bool> updateOrderStatus(int orderId, int newStateId) async {
var response = await crud.postData('${LinkApi.instance.orders}/$orderId', {'newStateId': newStateId});
    return response.fold((l) => false, (r) => r['success'] == true);
  }
}
