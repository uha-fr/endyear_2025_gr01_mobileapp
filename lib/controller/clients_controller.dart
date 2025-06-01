import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/remote/clientsData.dart';
import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/client_model.dart';

class ClientsController extends GetxController {
  var clients = <Customer>[].obs;

  // Observable for sorting option
  var sortOption = 'creation'.obs; // default: 'creation'

  List<Customer> get clientsList {
    List<Customer> sortedClients = List.from(clients);
    switch (sortOption.value) {
      case 'lastOrderDate':
        sortedClients.sort((a, b) {
          int? maxOrderIdA = a.orderIds?.isNotEmpty == true ? a.orderIds!.reduce((curr, next) => curr > next ? curr : next) : null;
          int? maxOrderIdB = b.orderIds?.isNotEmpty == true ? b.orderIds!.reduce((curr, next) => curr > next ? curr : next) : null;
          if (maxOrderIdA == null && maxOrderIdB == null) {
            return 0;
          }
          if (maxOrderIdA == null) return 1;
          if (maxOrderIdB == null) return -1;
          return maxOrderIdB.compareTo(maxOrderIdA); // descending
        });
        break;
      case 'name':
        sortedClients.sort((a, b) {
          int lastNameComp = a.lastname.toLowerCase().compareTo(b.lastname.toLowerCase());
          if (lastNameComp != 0) return lastNameComp;
          return a.firstname.toLowerCase().compareTo(b.firstname.toLowerCase());
        });
        break;
      case 'creation':
      default:
        sortedClients.sort((a, b) {
          DateTime dateA = DateTime.tryParse(a.dateAdd) ?? DateTime(1970);
          DateTime dateB = DateTime.tryParse(b.dateAdd) ?? DateTime(1970);
          return dateB.compareTo(dateA); // descending
        });
        break;
    }
    return sortedClients;
  }

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
