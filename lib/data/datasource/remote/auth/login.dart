import 'package:endyear_2025_gr01_mobileapp/core/class/crud.dart';
import 'package:endyear_2025_gr01_mobileapp/linkapi.dart';

class LoginData {
   Crud crud;
  LoginData(this.crud);

  postdata(String email, String password) async {
var response = await crud.postData(LinkApi.instance.auth, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}