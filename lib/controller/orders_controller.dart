import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'dart:convert';

class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;
  var isLoading = true.obs;

  // Use 10.0.2.2 instead of localhost for Android emulator
  final String baseUrl = 'http://localhost:8080/api';
  final String apiKey = 'DEIA6LJJEPA8NFEJTHGXY2AVX9IWE9P1';

  @override
  void onInit() {
    super.onInit();
    print('OrderController initialized');
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    print('Fetching orders...');
    try {
      final url = Uri.parse('$baseUrl/orders?display=full');
      print('API URL: $url');

      final String credentials = base64Encode(
        utf8.encode('$apiKey:'),
      ); // Proper Basic Auth
      print('Sending request with Basic Auth...');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Basic $credentials',
          'Accept': 'application/xml',
        },
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Response body length: ${response.body.length}');
        print(
          'First 100 chars of response: ${response.body.substring(0, min(100, response.body.length))}',
        );

        try {
          final document = xml.XmlDocument.parse(response.body);
          print('XML document parsed successfully');

          final ordersElements = document.findAllElements('order');
          print('Found ${ordersElements.length} order elements');

          final fetchedOrders = <OrderModel>[];
          for (var element in ordersElements) {
            try {
              print('Parsing order with ID: ${element.getElement('id')?.text}');
              final order = OrderModel.fromXml(element);
              fetchedOrders.add(order);
              print('Successfully parsed order with ID: ${order.id}');
            } catch (e) {
              print('Error parsing individual order: $e');
            }
          }

          // Fetch customer information
          for (var order in fetchedOrders) {
            await fetchCustomerInfo(order);
          }

          orders.assignAll(fetchedOrders);
          print('Orders list updated with ${orders.length} items');
        } catch (e) {
          print('Error parsing XML: $e');
        }
      } else {
        print('Failed to fetch orders: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error in fetchOrders: $e');
      if (e is http.ClientException) {
        print('HTTP Client Exception: ${e.message}');
      }
    } finally {
      isLoading.value = false;
      print('Loading state set to false');
    }
  }

  Future<void> fetchCustomerInfo(OrderModel order) async {
    print('Fetching customer info for customer ID: ${order.idCustomer}');
    try {
      final url = Uri.parse('$baseUrl/customers/${order.idCustomer}');
      print('Customer API URL: $url');

      final String credentials = base64Encode(
        utf8.encode('$apiKey:'),
      ); // Same encoding
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Basic $credentials',
          'Accept': 'application/xml',
        },
      );

      print('Customer API response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          final document = xml.XmlDocument.parse(response.body);
          print('Customer XML parsed successfully');

          final customerElements = document.findAllElements('customer');
          print('Found ${customerElements.length} customer elements');

          if (customerElements.isNotEmpty) {
            final customerElement = customerElements.first;
            final firstName =
                customerElement.getElement('firstname')?.text ?? 'Anonymous';
            final lastName =
                customerElement.getElement('lastname')?.text ?? 'Anonymous';

            final updatedOrder = OrderModel(
              id: order.id,
              idAddressDelivery: order.idAddressDelivery,
              idAddressInvoice: order.idAddressInvoice,
              idCart: order.idCart,
              idCurrency: order.idCurrency,
              idLang: order.idLang,
              idCustomer: order.idCustomer,
              idCarrier: order.idCarrier,
              currentState: order.currentState,
              module: order.module,
              payment: order.payment,
              dateAdd: order.dateAdd,
              reference: order.reference,
              totalPaid: order.totalPaid,
              totalPaidTaxIncl: order.totalPaidTaxIncl,
              totalPaidTaxExcl: order.totalPaidTaxExcl,
              customerName: '$firstName $lastName',
              orderRows: order.orderRows,
            );

            final index = orders.indexWhere((o) => o.id == order.id);
            if (index != -1) {
              orders[index] = updatedOrder;
              print('Updated order at index $index with customer name');
            } else {
              orders.add(updatedOrder);
              print('Order not found in list, added with customer name');
            }
          } else {
            print('No customer element found in XML response');
          }
        } catch (e) {
          print('Error parsing customer XML: $e');
        }
      } else {
        print('Failed to fetch customer info: ${response.statusCode}');
        print('Customer response body: ${response.body}');
      }
    } catch (e) {
      print('Error in fetchCustomerInfo: $e');
    }
  }

  int min(int a, int b) {
    return a < b ? a : b;
  }
}
