import 'package:endyear_2025_gr01_mobileapp/controller/orderdetails_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/clients_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CommandsDetailsPage extends StatelessWidget {
  const CommandsDetailsPage({super.key});

  // Helper method to format date
  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'Non disponible';
    try {
      return DateFormat('d MMMM yyyy', 'fr_FR').format(dateTime);
    } catch (e) {
      return dateTime.toString();
    }
  }

  // Helper method to get status color
  Color _getStatusColor(int? currentState) {
    switch (currentState) {
      case 1: // Processing
        return Colors.blue;
      case 2: // Shipped
        return Colors.orange;
      case 3: // Pending
        return Colors.amber;
      case 4: // Delivered
        return Colors.green;
      case 5: // Canceled
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Helper method to get status text
  String _getStatusText(int? currentState) {
    switch (currentState) {
      case 1:
        return 'En traitement';
      case 2:
        return 'Expédié';
      case 3:
        return 'En attente';
      case 4:
        return 'Livré';
      case 5:
        return 'Annulé';
      default:
        return 'Inconnu';
    }
  }

  // Helper method to get status icon
  IconData _getStatusIcon(int? currentState) {
    switch (currentState) {
      case 1: // Processing
        return Icons.pending_actions;
      case 2: // Shipped
        return Icons.local_shipping;
      case 3: // Pending
        return Icons.hourglass_empty;
      case 4: // Delivered
        return Icons.check_circle;
      case 5: // Canceled
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize French locale for date formatting
    initializeDateFormatting('fr_FR', null);

    final OrdersDetailsController controller = Get.find();
    final ClientsController clientsController = Get.find();
    final order = controller.order;
    final client = clientsController.clientsList.firstWhereOrNull(
      (c) => c.id == order.idCustomer,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.shopping_bag,
                              size: 40,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Commande ${order.reference}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            client != null
                                ? '${client.firstname} ${client.lastname}'
                                : 'Client inconnu',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                  // Status bar
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                          icon: _getStatusIcon(order.currentState),
                          label: 'Statut',
                          value: _getStatusText(order.currentState),
                          color: _getStatusColor(order.currentState),
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        _buildStatusItem(
                          icon: Icons.payments,
                          label: 'Paiement',
                          value: order.payment ?? 'Inconnu',
                          color: Colors.green,
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        _buildStatusItem(
                          icon: Icons.card_giftcard,
                          label: 'Cadeau',
                          value: order.gift == true ? 'Oui' : 'Non',
                          color: order.gift == true ? Colors.pink : Colors.grey,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Order Information Section
                  _buildSectionTitle('Détails de la Commande'),
                  _buildInfoCard([
                    _buildDetailItem(
                      Icons.numbers,
                      'Référence',
                      order.reference ?? 'Non disponible',
                    ),
                    _buildDetailItem(
                      Icons.shopping_cart,
                      'ID Panier',
                      '${order.idCart ?? 'Non disponible'}',
                    ),
                    _buildDetailItem(
                      Icons.calendar_today,
                      'Date de commande',
                      formatDate(order.dateAdd),
                    ),
                    _buildDetailItem(
                      Icons.update,
                      'Dernière mise à jour',
                      formatDate(order.dateUpd),
                    ),
                  ]),

                  SizedBox(height: 20),

                  // Payment Information Section
                  _buildSectionTitle('Informations de Paiement'),
                  _buildInfoCard([
                    _buildDetailItem(
                      Icons.paid,
                      'Total payé',
                      '\$${order.totalPaid?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                    _buildDetailItem(
                      Icons.receipt,
                      'Total TTC',
                      '\$${order.totalPaidTaxIncl?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                    _buildDetailItem(
                      Icons.receipt_long,
                      'Total HT',
                      '\$${order.totalPaidTaxExcl?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                    _buildDetailItem(
                      Icons.shopping_bag_outlined,
                      'Total Produits',
                      '\$${order.totalProducts?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                    _buildDetailItem(
                      Icons.local_shipping_outlined,
                      'Frais de Livraison',
                      '\$${order.totalShipping?.toStringAsFixed(2) ?? '0.00'}',
                    ),
                  ]),

                  SizedBox(height: 20),

                  // Shipping Information
                  _buildSectionTitle('Informations de Livraison'),
                  _buildInfoCard([
                    _buildDetailItem(
                      Icons.local_shipping,
                      'ID Transporteur',
                      '${order.idCarrier ?? 'Non disponible'}',
                    ),
                    _buildDetailItem(
                      Icons.home,
                      'ID Adresse de Livraison',
                      '${order.idAddressDelivery ?? 'Non disponible'}',
                    ),
                    _buildDetailItem(
                      Icons.receipt,
                      'ID Adresse de Facturation',
                      '${order.idAddressInvoice ?? 'Non disponible'}',
                    ),
                    _buildDetailItem(
                      Icons.recycling,
                      'Recyclable',
                      order.recyclable == true ? 'Oui' : 'Non',
                    ),
                  ]),

                  // Gift message section (only if gift is true)
                  if (order.gift == true) ...[
                    SizedBox(height: 20),
                    _buildSectionTitle('Message de Cadeau'),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.pink[100]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.card_giftcard, color: Colors.pink),
                              SizedBox(width: 8),
                              Text(
                                'Message',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            order.giftMessage ?? 'Aucun message',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for UI components
  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        SizedBox(height: 2),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
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
          Column(
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
                  fontWeight: isAvailable ? FontWeight.w500 : FontWeight.normal,
                  color: isAvailable ? Colors.black87 : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
