import 'package:endyear_2025_gr01_mobileapp/core/constants/color.dart';
import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomButtonAuth(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
     margin: EdgeInsets.only(top: 10),
     child: MaterialButton(onPressed: onPressed,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
       padding: const EdgeInsets.symmetric(vertical: 13),
       color: AppColor.primaryColor,
       textColor: Colors.white,
       child: Text(text),
     ),
   );
  }

}