import 'dart:convert';

import 'package:endyear_2025_gr01_mobileapp/core/class/statusrequest.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class Crud {
  Future<Either<StatusRequest, Map>> getData(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data['success'] == true) {
          return Right(data);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> postData(String url, Map data) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          return Right(responseData);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e, stacktrace) {
      print('Crud: exception caught: $e');
      print('Crud: stacktrace: $stacktrace');
      return const Left(StatusRequest.serverException);
    }
  }
}
