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
      appBar: AppBar(
        title: const Text('Clients'),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return DropdownButton<String>(
                value: controller.sortOption.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.sortOption.value = value;
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: 'lastOrderDate',
                    child: Text('Date de dernière commande'),
                  ),
                  DropdownMenuItem(
                    value: 'name',
                    child: Text('Nom (alphabets)'),
                  ),
                  DropdownMenuItem(
                    value: 'creation',
                    child: Text('Par ordre de création'),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              print('ClientsPage: clientsList length: ${controller.clientsList.length}');
              return ListView.builder(
                itemCount: controller.clientsList.length,
                itemBuilder: (context, index) {
                  final client = controller.clientsList[index];
                  return CustomClientCard(
                    client: client,
                    onTap: () {
                      detailsController.setClient(client);
                      Get.to(() => ClientDetailsPage());
                    },
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
