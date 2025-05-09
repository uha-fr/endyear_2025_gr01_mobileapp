import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../core/constants/imageassets.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Login",style:Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColor.grey,)),
        ),
        body: WillPopScope( onWillPop: null,
            child: GetBuilder<LoginControllerImp>(
                builder: (controller)=>
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15,horizontal: 30
                      ),
                      child: Form(key:controller.formstate,
                          child: ListView(
                            children: [
                              Image.asset(AppImageAsset.logo,height: 170,),
                              CustomTextTitleAuth(text:"Welcome"),
                              const SizedBox(height: 10,),
                              CustomTextBodyAuth(
                                text: "back".tr,
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              CustomTextFormAuth(
                                isNumber:false,
                                valid:(val){

                                },
                                hinttext: "Email".tr,
                                labeltext: "Email".tr,
                                icondata: Icons.email_outlined,
                                mycontroller: controller.email,
                              ),
                              GetBuilder<LoginControllerImp>(builder: (controller)=>CustomTextFormAuth(
                                  obscureText: null,
                                  onTapIcon: () {

                                  },
                                  isNumber: false,
                                  valid: (val) {

                                  },
                                  hinttext: "Password".tr,
                                  labeltext: "Passowrd".tr,
                                  icondata: Icons.lock_outlined,
                                  mycontroller: controller.passowrd),
                              ),
                              CustomButtonAuth(
                                  text: "Login".tr,
                                  onPressed: () {
                                    controller.login();
                                  }),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          )),
                    )
            )));

  }


}
