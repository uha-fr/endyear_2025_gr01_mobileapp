import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/client_model.dart';

class ClientDetailsResponse {
  final Customer? customer;
  final List<int> orderIds;

  ClientDetailsResponse({this.customer, required this.orderIds});
}

class ClientDetailsData {
  final Crud crud;
  ClientDetailsData(this.crud);

  Future<ClientDetailsResponse?> getData(int id) async {
    var response = await crud.getData(
'${LinkApi.instance.server}/customerDetails.php?id=$id',
    );
    return response.fold(
      (l) {
        return null;
      },
      (r) {
        if (r['success'] == true) {
          Customer customer = Customer.fromJson(r['customer']);
          List<int> orderIds = [];
          if (r['order_ids'] != null) {
            orderIds =
                (r['order_ids'] as List<dynamic>).map((e) => e as int).toList();
          }
          return ClientDetailsResponse(customer: customer, orderIds: orderIds);
        } else {
          return null;
        }
      },
    );
  }
}
