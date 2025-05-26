import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/orderdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrdersDetailsController controller =
      Get.find<OrdersDetailsController>();

  OrderDetailsScreen({Key? key}) : super(key: key);

  // Helper method to format date
  String formatDate(String dateStr) {
    if (dateStr.isEmpty) return 'Non disponible';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMMM yyyy à HH:mm', 'fr_FR').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  // Helper method to get payment method
  String _getPaymentMethod(String module, String payment) {
    switch (module) {
      case 'ps_wirepayment':
        return 'Virement bancaire';
      case 'ps_checkpayment':
        return 'Chèque';
      case 'ps_cashondelivery':
        return 'Paiement à la livraison';
      default:
        return payment;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize French locale for date formatting
    initializeDateFormatting('fr_FR', null);

    return Scaffold(
      body: Obx(() {
        OrderModel? order = controller.order.value;

        if (order == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Détails de la commande')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Chargement des détails...'),
                ],
              ),
            ),
          );
        }

        String paymentMethod = _getPaymentMethod(order.module, order.payment);

        return Scaffold(
          appBar: AppBar(title: Text(order.reference)),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Order Info
                Text(
                  'Informations de la commande:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Référence: ${order.reference}'),
                Text('Client: ${order.customerName}'),
                Text('Date: ${formatDate(order.dateAdd)}'),
                Text('Statut: ${order.currentStateName}'),
                Text('Paiement: $paymentMethod'),
                Text('Total: ${order.totalPaidTaxIncl.toStringAsFixed(2)}€'),

                SizedBox(height: 20),

                // Delivery Address
                Text(
                  'Adresse de livraison:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (order.deliveryAddress.address1.isNotEmpty)
                  Text('${order.deliveryAddress.address1}'),
                if (order.deliveryAddress.address2.isNotEmpty)
                  Text('${order.deliveryAddress.address2}'),
                Text(
                  '${order.deliveryAddress.city}, ${order.deliveryAddress.postcode}',
                ),
                Text('${order.deliveryAddress.country}'),

                SizedBox(height: 20),

                // Invoice Address
                Text(
                  'Adresse de facturation:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (order.invoiceAddress.address1.isNotEmpty)
                  Text('${order.invoiceAddress.address1}'),
                if (order.invoiceAddress.address2.isNotEmpty)
                  Text('${order.invoiceAddress.address2}'),
                Text(
                  '${order.invoiceAddress.city}, ${order.invoiceAddress.postcode}',
                ),
                Text('${order.invoiceAddress.country}'),

                // Gift Message (if applicable)
                if (order.gift) ...[
                  SizedBox(height: 20),
                  Text(
                    'Message cadeau:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('${order.giftMessage}'),
                ],

                SizedBox(height: 20),

                // Products
                Text(
                  'Produits:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...order.products.map(
                  (product) => InkWell(
                    onTap: () {
                      // Convert Product to ProductModel to pass to product details screen
                      var productModel = ProductModel(
                        productId: product.productId,
                        productName: product.productName,
                        productPrice: product.productPrice,
                        productCount: product.productQuantity,
                        productDesc: '',
                        productImage: '',
                        productActive: true,
                        productDate: '',
                        productCat: 0,
                        categoriesId: 0,
                        categoriesName: '',
                        categoriesImage: '',
                        categoriesDatetime: '',
                        reference: '',
                        condition: '',
                        manufacturer: '',
                        weight: 0.0,
                        availableNow: '',
                        availableLater: '',
                        descriptionShort: '',
                        additionalShippingCost: 0,
                        wholesalePrice: 0.0,
                        unity: '',
                        allImages: [],
                      );
                      Get.toNamed(
                        'productdetails',
                        arguments: {'productModel': productModel},
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${product.productName}'),
                          Text('Quantité: ${product.productQuantity}'),
                          Text(
                            'Prix: ${product.productPrice.toStringAsFixed(2)}€',
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
