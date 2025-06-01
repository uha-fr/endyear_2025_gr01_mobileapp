import 'package:endyear_2025_gr01_mobileapp/controller/auth/login_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/orders_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/controller/clients_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:endyear_2025_gr01_mobileapp/view/widget/orders/customordercard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommandesPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  final ClientsController clientsController = Get.put(ClientsController());

  CommandesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commandes'),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
              child: IconButton(
                onPressed: () {
                  final loginController = Get.find<LoginControllerImp>();
                  loginController.logout();
                },
                icon: const Icon(
                  Icons.exit_to_app_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filtrer par état
                Obx(() {
  
                  return DropdownButton<int>(
                    isDense: true,
                    value: orderController.selectedState.value,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('All')),
                      DropdownMenuItem(
                        value: 1,
                        child: Text('En attente du paiement par chèque'),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Paiement accepté'),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text('En cours de préparation'),
                      ),
                      DropdownMenuItem(value: 4, child: Text('Expédié')),
                      DropdownMenuItem(value: 5, child: Text('Livré')),
                      DropdownMenuItem(value: 6, child: Text('Annulé')),
                      DropdownMenuItem(value: 7, child: Text('Remboursé')),
                      DropdownMenuItem(
                        value: 8,
                        child: Text('Erreur de paiement'),
                      ),
                      DropdownMenuItem(
                        value: 9,
                        child: Text('En attente de réapprovisionnement (payé)'),
                      ),
                      DropdownMenuItem(
                        value: 10,
                        child: Text('En attente de virement bancaire'),
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
                        child: Text('En attente de paiement à la livraison'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        orderController.updateFilterState(value);
                      }
                    },
                  );
                }),
                // Trier par date
                Obx(() {

                  return DropdownButton<bool>(
                    isDense: true,
                    value: orderController.sortAscending.value,
                    items: const [
                      DropdownMenuItem(value: true, child: Text('Date Asc')),
                      DropdownMenuItem(value: false, child: Text('Date Desc')),
                    ],
                    onChanged: (value) {
                      if (value != null) {

                        orderController.updateSortOrder(value);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (orderController.orders.isEmpty) {

                return const Center(child: CircularProgressIndicator());
              }
              final filteredOrders = orderController.filteredSortedOrders;

              if (filteredOrders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }
              return ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  final client = clientsController.clientsList.firstWhereOrNull(
                    (c) => c.id == order.idCustomer,
                  );
                  final clientName =
                      client != null
                          ? '${client.firstname} ${client.lastname}'
                          : order
                              .customerName; // fallback to order.customerName

                  return GestureDetector(
                    onTap: () {
                      Get.toNamed('/orderdetails', arguments: order.id);
                    },
                    child: CustomOrderCard(
                      orderId: order.reference.toString(),
                      customerName: clientName,
                      date: order.dateAdd.toString(),
                      amount: order.totalPaidTaxIncl,
                      status: order.currentStateName,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
