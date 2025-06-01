import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/configbackendcontroller.dart';
import '../../core/constants/color.dart';
import '../../core/constants/imageassets.dart';
import '../../core/functions/alertexitapp.dart';
import '../../core/functions/validinput.dart';
import '../widget/auth/custombuttonauth.dart';
import '../widget/auth/customtextbodyauth.dart';
import '../widget/auth/customtexttitleauth.dart';
import '../widget/auth/customtextformauth.dart';

class Config extends StatelessWidget {
  Config({Key? key}) : super(key: key);

  final ConfigBackendController controller = Get.put(ConfigBackendController());
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Configuration",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: AppColor.grey,
              ),
        ),
      ),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: ListView(
            children: [
              Image.asset(AppImageAsset.logo, height: 170),
              CustomTextTitleAuth(text: "Entrez l'URL du Back Office"),
              const SizedBox(height: 10),
              CustomTextBodyAuth(
                  text: "Veuillez saisir l'URL de votre back office ci-dessous"),
              const SizedBox(height: 45),
              CustomTextFormAuth(
                isNumber: false,
                valid: (val) {
                  return validInput(val!, 5, 200, "url");
                },
                hinttext: "Entrez l'URL",
                labeltext: "URL du Back Office",
                icondata: Icons.link,
                mycontroller: urlController,
              ),
              CustomButtonAuth(
                text: "Soumettre",
                onPressed: () async {
                  String url = urlController.text.trim();
                  if (url.isNotEmpty) {
                    await controller.saveServerUrl(url);
                    Get.snackbar('Succès', 'URL enregistrée avec succès');
                     Get.toNamed(AppRoutes.login);
                  } else {
                    Get.snackbar('Erreur', 'Veuillez entrer une URL valide');
                  }
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
