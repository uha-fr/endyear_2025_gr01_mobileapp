import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constants/imageassets.dart';
import '../../../core/functions/alertexitapp.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Connexion".tr, // "9"
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColor.grey,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    Image.asset(AppImageAsset.logo, height: 170),
                    CustomTextTitleAuth(
                      text: "Bienvenue"
                    ),
                    const SizedBox(height: 10),
                    CustomTextBodyAuth(
                      text: "Connectez-vous avec votre email et mot de passe"
                    ),
                    const SizedBox(height: 45),
                    CustomTextFormAuth(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 5, 100, "email");
                      },
                      hinttext: "Entrez votre email",
                      labeltext: "Adresse e-mail" ,
                      icondata: Icons.email_outlined,
                      mycontroller: controller.email,
                    ),
                    GetBuilder<LoginControllerImp>(
                      builder: (controller) => CustomTextFormAuth(
                        obscureText: controller.isShowPassword,
                        onTapIcon: () {
                          controller.showPassword();
                        },
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 5, 30, "password");
                        },
                        hinttext: "Entrez votre mot de passe",
                        labeltext: "Mot de passe",
                        icondata: Icons.lock_outlined,
                        mycontroller: controller.password,
                      ),
                    ),
                    CustomButtonAuth(
                      text: "Connexion",
                      onPressed: () {
                        controller.login();
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
