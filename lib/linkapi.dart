import 'package:get/get.dart';
import '../controller/configbackendcontroller.dart';

class LinkApi {
  static final LinkApi _instance = LinkApi._internal();

  factory LinkApi() {
    return _instance;
  }

  LinkApi._internal();

  final ConfigBackendController _configController = Get.find();

  String get server => _configController.serverUrl.value;

  String get auth => "$server/auth.php";

  String get products => "$server/products.php";

  String get productDetails => "$server/produitDetails.php";

  String get orders => "$server/orders.php";

  String get orderDetails => "$server/orderDetails.php";

  String get clients => "$server/customers.php";

  String get clientDetails => "$server/customerDetails.php";

  String get statistics => "$server/statistics.php";

  static LinkApi get instance => _instance;
}
