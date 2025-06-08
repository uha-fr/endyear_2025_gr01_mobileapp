import 'package:endyear_2025_gr01_mobileapp/controller/auth/login_controller.dart';
import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/clients_controller.dart';
import '../../controller/clientdetails_controller.dart';
import '../widget/clients/customclientcard.dart';
import 'client_details.dart';

class ClientsPage extends StatelessWidget {
  final ClientsController controller = Get.put(ClientsController());
  final ClientDetailsController detailsController = Get.put(
    ClientDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 70,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: const Text(
                'Clients',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor,
                      AppColor.primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    final loginController = Get.find<LoginControllerImp>();
                    loginController.logout();
                  },
                  icon: const Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // 🔍 Barre de recherche
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Rechercher par nom ou prénom...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onChanged: (value) => controller.searchQuery.value = value,
                  ),
                ),
                // ⬇️ Menu déroulant pour le tri
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Obx(() {
                    return DropdownButton<String>(
                      value: controller.sortOption.value,
                      isExpanded: true,
                      onChanged: (value) {
                        if (value != null) {
                          controller.sortOption.value = value;
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'creation',
                          child: Text('Par ordre de création'),
                        ),
                        DropdownMenuItem(
                          value: 'name',
                          child: Text('Nom (alphabétique)'),
                        ),
                        DropdownMenuItem(
                          value: 'lastOrderDate',
                          child: Text('Date de dernière commande'),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          // 📋 Liste des clients
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Obx(() {
                final clients = controller.clientsList;
                if (index >= clients.length) {
                  return const SizedBox.shrink();
                }
                final client = clients[index];
                return CustomClientCard(
                  client: client,
                  onTap: () {
                    detailsController.setClient(client);
                    Get.to(() => ClientDetailsPage());
                  },
                );
              });
            }, childCount: controller.clientsList.length),
          ),
        ],
      ),
    );
  }
}
