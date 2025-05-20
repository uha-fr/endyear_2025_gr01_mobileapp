import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;
  var isLoading = true.obs;

  // URL of the PHP intermediary script
  final String phpIntermediaryUrl = 'http://localhost/xampp/api.php';

  @override
  void onInit() {
    super.onInit();
    print('OrderController initialized');
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    print('Fetching orders from PHP intermediary...');
    try {
      final url = Uri.parse(phpIntermediaryUrl);
      print('PHP intermediary URL: $url');

      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Response body length: ${response.body.length}');
        print(
          'First 100 chars of response: ${response.body.substring(0, response.body.length < 100 ? response.body.length : 100)}',
        );

        try {
          final Map<String, dynamic> topLevelJson = json.decode(response.body);
          if (topLevelJson['success'] == true) {
            final String nestedResponse = topLevelJson['response'];
            final Map<String, dynamic> nestedJson = json.decode(nestedResponse);
            final List<dynamic> ordersJson = nestedJson['orders'] ?? [];

            print('Parsed ${ordersJson.length} orders from nested response');

            final fetchedOrders = ordersJson.map((orderJson) => OrderModel.fromJson(orderJson)).toList();

            orders.assignAll(fetchedOrders);
            print('Orders list updated with ${orders.length} items');
          } else {
            print('API returned success=false');
            print('Response: ${response.body}');
          }
        } catch (e) {
          print('Error parsing JSON: $e');
        }
      } else {
        print('Failed to fetch orders: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error in fetchOrders: $e');
    } finally {
      isLoading.value = false;
      print('Loading state set to false');
    }
  }
}
