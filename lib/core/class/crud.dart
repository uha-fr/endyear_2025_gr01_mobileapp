import 'dart:convert';

import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class Crud {
  Future<Either<StatusRequest, Map>> getData(String url) async {
    print('Crud: getData called with url: $url');
    try {
      var response = await http.get(Uri.parse(url));
      print('Crud: HTTP response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print('Crud: response body decoded: $data');
        if (data['success'] == true) {
          return Right(data);
        } else {
          print('Crud: response success field false');
          return const Left(StatusRequest.failure);
        }
      } else {
        print('Crud: HTTP response status not 200');
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print('Crud: exception caught: $e');
      return const Left(StatusRequest.serverException);
    }
  }
}
