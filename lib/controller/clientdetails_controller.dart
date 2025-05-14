import 'package:get/get.dart';
import '../data/datasource/models/client_model.dart';

class ClientDetailsController extends GetxController {
  var selectedClient = Rxn<Customer>();

  void setClient(Customer client) {
    selectedClient.value = client;
  }
}
