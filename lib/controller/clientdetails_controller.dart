import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/clientDetailsData.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/client_model.dart';

class ClientDetailsController extends GetxController {
  var client = Rxn<Customer>();
  var orderIds = <int>[].obs;

  late ClientDetailsData clientDetailsData;

  Rxn<Customer> get selectedClient => client;

  @override
  void onInit() {
    super.onInit();
    clientDetailsData = ClientDetailsData(Crud());
  }

  void setClient(Customer c) {
    client.value = c;
    fetchClientDetails(c.id);
  }

  void fetchClientDetails(int id) async {
    var data = await clientDetailsData.getData(id);
    if (data != null) {
      client.value = data.customer;
      orderIds.value = data.orderIds;
    }
  }
}
