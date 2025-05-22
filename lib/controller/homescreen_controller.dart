import 'package:endyear_2025_gr01_mobileapp/view/screen/clients.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/orders.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/home.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/products.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int currentpage);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;

  List bottomappbar = [
    {"title": "Commandes", 'icon': Icons.shopping_cart},
    {"title": "Produits", 'icon': Icons.category},
    {"title": "Clients", 'icon': Icons.person},
    {"title": "Taches", 'icon': Icons.task},
  ];

  List<Widget> listPage = [
    HomePage(),
    CommandesPage(),
    ProductsPage(),
    ClientsPage(),
    TasksPage(),
  ];

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
