import 'package:endyear_2025_gr01_mobileapp/core/constants/routes.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/auth/login.dart';
import 'package:endyear_2025_gr01_mobileapp/view/screen/home.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


List<GetPage<dynamic>>? routes = [


  //Auth
  GetPage(name: AppRoutes.login, page: () => const Login()),

  // Home
  GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
];
