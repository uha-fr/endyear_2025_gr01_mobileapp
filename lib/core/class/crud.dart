import 'dart:convert';

import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../functions/checkinternet.dart';

class Crud {

  Future<Either<StatusRequest, Map>> getData(String url) async {
    try {
      print("qbl internet");
      print("internet kayna mais qbl response");
      var response = await http.get(Uri.parse(url));
      print("internet kayna w mn b3d response");
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print("res2 -- $data");
        if (data['success'] == true) {
          print("khdaaaaaaaam");
          return Right(data);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
}
