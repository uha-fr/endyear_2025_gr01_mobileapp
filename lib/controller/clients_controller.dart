import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/clientsData.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/client_model.dart';

class ClientsController extends GetxController {
  var clients = <Customer>[].obs;

  List<Customer> get clientsList => clients;

  late ClientsData clientsData;

  @override
  void onInit() {
    super.onInit();
    clientsData = ClientsData(Crud());
    fetchClients();
  }

  void fetchClients() async {
    var data = await clientsData.getData();
    clients.assignAll(data);
  }
}
