import 'package:flutter/material.dart';

import 'core/constants/color.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        backgroundColor: AppColor.backgroundColor,
        body:
              ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Text("aaa");
                  }),
            );


  }
}
