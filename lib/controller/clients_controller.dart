import 'package:get/get.dart';
import '../data/datasource/models/client_model.dart';
import '../data/datasource/static/clients_data.dart';

class ClientsController extends GetxController {
  var clientsList = <Customer>[].obs;
  var selectedClient = Rxn<Customer>();

  @override
  void onInit() {
    super.onInit();
    // Initialize with static clients data
    clientsList.assignAll(clients);
  }

  void selectClient(Customer client) {
    selectedClient.value = client;
  }
}
