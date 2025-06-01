import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/client_model.dart';

class ClientsData {
  final Crud crud;
  ClientsData(this.crud);

  Future<List<Customer>> getData() async {
var response = await crud.getData(LinkApi.instance.clients);
    return response.fold((l) {
      return [];
    }, (r) {
      if (r['success'] == true) {
        List customersJson = r['customers'] ?? [];
        return customersJson.map((json) => Customer.fromJson(json)).toList();
      } else {
        return [];
      }
    });
  }
}
