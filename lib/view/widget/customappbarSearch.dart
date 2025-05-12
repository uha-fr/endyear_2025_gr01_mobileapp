import 'package:flutter/material.dart';

class CustomAppBarSearsh extends StatelessWidget {
  final String title;
 final void Function()? onPressedIcon;
  final void Function()? onPressedSearch;
  final void Function(String)? onChanged;
  final TextEditingController mycontroller;

  const CustomAppBarSearsh({
    super.key,
    required this.title,
    this.onPressedIcon,
    this.onPressedSearch,
    required this.onChanged,
    required this.mycontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          // for the search field
          Expanded(
              child: TextFormField(
            onChanged: onChanged,
            controller: mycontroller,  
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    icon: const Icon(Icons.search), onPressed: onPressedSearch),
                hintText: title,
                hintStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
                filled: true,
                fillColor: Colors.grey[200]),
          )),

          //for alert icon
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
                onPressed: onPressedIcon,
                icon: const Icon(
                  size: 30,
                  color: Colors.grey,
                  Icons.notifications_active_outlined,
                )),
          ),

          
        ],
      ),
    );
  }
}
