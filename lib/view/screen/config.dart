import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/configbackendcontroller.dart';

class Config extends StatelessWidget {
  Config({Key? key}) : super(key: key);

  final ConfigBackendController controller = Get.put(ConfigBackendController());
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuration'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: "Enter L'URL Back Office ",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String url = urlController.text.trim();
                if (url.isNotEmpty) {
                  await controller.saveServerUrl(url);
                  Get.snackbar('Success', 'URL enregistrer avec succé');
                  Get.toNamed(AppRoutes.login);
                } else {
                  Get.snackbar('Error', 'Enter un URL valid ');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
