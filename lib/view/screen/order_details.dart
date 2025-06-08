import 'package:endyear_2025_gr01_mobileapp/controller/productdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/orderdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/data/datasource/models/order_model.dart';
import '../../core/constants/color.dart';
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

  // Helper method to get payment icon
  IconData _getPaymentIcon(String module) {
    switch (module) {
      case 'ps_wirepayment':
        return Icons.account_balance;
      case 'ps_checkpayment':
        return Icons.receipt;
      case 'ps_cashondelivery':
        return Icons.local_shipping;
      default:
        return Icons.payment;
    }
  }

  // Helper method to get status color
  Color _getStatusColor(int statusId) {
    switch (statusId) {
      case 2: // Paiement accepté
      case 5: // Livré
        return Colors.green;
      case 3: // En cours de préparation
      case 4: // Expédié
        return Colors.blue;
      case 1: // En attente
      case 10: // En attente de virement
      case 13: // En attente de paiement
        return Colors.orange;
      case 6: // Annulé
      case 8: // Erreur de paiement
        return Colors.red;
      case 7: // Remboursé
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize French locale for date formatting
    initializeDateFormatting('fr_FR', null);

    return Obx(() {
      OrderModel? order = controller.order.value;

      if (order == null) {
        return Scaffold(
          appBar: AppBar(title: Text('Détails de la commande')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColor.primaryColor),
                SizedBox(height: 16),
                Text(
                  'Chargement des détails...',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      }

      String paymentMethod = _getPaymentMethod(order.module, order.payment);

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  '${order.reference}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColor.primaryColor,
                            AppColor.primaryColor.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            Icons.shopping_cart,
                            size: 48,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status and summary bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatusItem(
                            icon: Icons.receipt_long,
                            label: 'Statut',
                            value: order.currentStateName,
                            color: _getStatusColor(order.currentStateId),
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          _buildStatusItem(
                            icon: _getPaymentIcon(order.module),
                            label: 'Paiement',
                            value: paymentMethod,
                            color: Colors.blue,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          _buildStatusItem(
                            icon: Icons.euro,
                            label: 'Total',
                            value:
                                '${order.totalPaidTaxIncl.toStringAsFixed(2)}€',
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Order Information Section
                    _buildSectionTitle('Informations de la commande'),
                    _buildInfoCard([
                      _buildDetailItem(
                        Icons.confirmation_number,
                        'Référence',
                        order.reference,
                      ),
                      _buildDetailItem(
                        Icons.person,
                        'Client',
                        order.customerName,
                      ),
                      _buildDetailItem(
                        Icons.access_time,
                        'Date de commande',
                        formatDate(order.dateAdd),
                      ),
                    ]),

                    SizedBox(height: 16),

                    // Status Update Section
                    _buildSectionTitle('Gestion du statut'),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Modifier le statut de la commande',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: order.currentStateId,
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      'En attente du paiement par chèque',
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('Paiement accepté'),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text('En cours de préparation'),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text('Expédié'),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text('Livré'),
                                  ),
                                  DropdownMenuItem(
                                    value: 6,
                                    child: Text('Annulé'),
                                  ),
                                  DropdownMenuItem(
                                    value: 7,
                                    child: Text('Remboursé'),
                                  ),
                                  DropdownMenuItem(
                                    value: 8,
                                    child: Text('Erreur de paiement'),
                                  ),
                                  DropdownMenuItem(
                                    value: 9,
                                    child: Text(
                                      'En attente de réapprovisionnement (payé)',
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 10,
                                    child: Text(
                                      'En attente de virement bancaire',
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 11,
                                    child: Text('Paiement à distance accepté'),
                                  ),
                                  DropdownMenuItem(
                                    value: 12,
                                    child: Text(
                                      'En attente de réapprovisionnement (non payé)',
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 13,
                                    child: Text(
                                      'En attente de paiement à la livraison',
                                    ),
                                  ),
                                ],
                                onChanged: (newValue) async {
                                  if (newValue != null) {
                                    bool success = await controller
                                        .updateOrderStatus(order.id!, newValue);
                                    if (success) {
                                      Get.snackbar(
                                        'Succès',
                                        'Statut mis à jour avec succès',
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                      );
                                    } else {
                                      Get.snackbar(
                                        'Erreur',
                                        'Échec de la mise à jour du statut',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Delivery Address Section
                    _buildSectionTitle('Adresse de livraison'),
                    _buildInfoCard([
                      if (order.deliveryAddress.address1.isNotEmpty)
                        _buildDetailItem(
                          Icons.location_on,
                          'Adresse',
                          order.deliveryAddress.address1,
                        ),
                      if (order.deliveryAddress.address2.isNotEmpty)
                        _buildDetailItem(
                          Icons.location_on_outlined,
                          'Complément',
                          order.deliveryAddress.address2,
                        ),
                      _buildDetailItem(
                        Icons.location_city,
                        'Ville',
                        '${order.deliveryAddress.city}, ${order.deliveryAddress.postcode}',
                      ),
                      _buildDetailItem(
                        Icons.flag,
                        'Pays',
                        order.deliveryAddress.country,
                      ),
                    ]),

                    SizedBox(height: 20),

                    // Invoice Address Section
                    _buildSectionTitle('Adresse de facturation'),
                    _buildInfoCard([
                      if (order.invoiceAddress.address1.isNotEmpty)
                        _buildDetailItem(
                          Icons.receipt_long,
                          'Adresse',
                          order.invoiceAddress.address1,
                        ),
                      if (order.invoiceAddress.address2.isNotEmpty)
                        _buildDetailItem(
                          Icons.receipt_long_outlined,
                          'Complément',
                          order.invoiceAddress.address2,
                        ),
                      _buildDetailItem(
                        Icons.location_city,
                        'Ville',
                        '${order.invoiceAddress.city}, ${order.invoiceAddress.postcode}',
                      ),
                      _buildDetailItem(
                        Icons.flag,
                        'Pays',
                        order.invoiceAddress.country,
                      ),
                    ]),

                    // Gift Message Section
                    if (order.gift) ...[
                      SizedBox(height: 20),
                      _buildSectionTitle('Message cadeau'),
                      _buildInfoCard([
                        _buildDetailItem(
                          Icons.card_giftcard,
                          'Message',
                          order.giftMessage,
                        ),
                      ]),
                    ],

                    SizedBox(height: 20),

                    // Products Section
                    _buildSectionTitle('Produits (${order.products.length})'),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children:
                            order.products.asMap().entries.map((entry) {
                              int index = entry.key;
                              var product = entry.value;
                              bool isLast = index == order.products.length - 1;

                              return InkWell(
                                onTap: () {
                                  controller.goToProductDetails(
                                    product.productId,
                                  );
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.shopping_bag,
                                              color: AppColor.primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product.productName,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Quantité: ${product.productQuantity}',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                    SizedBox(width: 16),
                                                    Text(
                                                      'Prix: ${product.productPrice.toStringAsFixed(2)}€',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                            color: Colors.grey[400],
                                          ),
                                        ],
                                      ),
                                      if (!isLast)
                                        Divider(
                                          height: 16,
                                          color: Colors.grey[200],
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper methods for UI components
  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String label,
    String value, {
    bool isAvailable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  isAvailable
                      ? AppColor.primaryColor.withOpacity(0.1)
                      : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isAvailable ? AppColor.primaryColor : Colors.grey,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        isAvailable ? FontWeight.w500 : FontWeight.normal,
                    color: isAvailable ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
