import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/order_model.dart';

class OrderDetailsData {
  Crud crud;
  OrderDetailsData(this.crud);

  Future<OrderModel?> getData(int id) async {
    print('OrderDetailsData: getData called with id: \$id');
    var response = await crud.getData('\${LinkApi.orderDetails}?id=\$id');
    print('OrderDetailsData: response received: \$response');
    return response.fold((l) => null, (r) {
      if (r['success'] == true) {
        var orderJson = r['order'];
        print('OrderDetailsData: success true, parsing orderJson');
        return OrderModel.fromJson(orderJson);
      } else {
        print('OrderDetailsData: success false in response');
        return null;
      }
    });
  }
}
