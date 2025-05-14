import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/auth/login.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/order_details.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/home.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/homescreen.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/productdetails.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/clients.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/client_details.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? routes = [
  //Auth
  GetPage(name: AppRoutes.login, page: () => const Login()),

  // Home
  GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
  GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen()),

  //Product
  GetPage(name: AppRoutes.productdetails, page: () => const ProductDetails()),

  GetPage(name: '/commandsdetails', page: () => const CommandsDetailsPage()),

  // Clients
  GetPage(name: '/clients', page: () => ClientsPage()),
  GetPage(name: '/clientdetails', page: () => ClientDetailsPage()),
];
