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
      appBar: AppBar(
        title: const Text('Clients'),
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
      body: Obx(() {
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
    );
  }
}
