import 'dart:convert';

import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class ProductsData {
  Crud crud;
  ProductsData(this.crud);

  Future<List> getData() async {
    var response = await crud.getData(LinkApi.products);
    print("res --- $response");
    return response.fold((l) => [], (r) {
      if (r['success'] == true) {
        print("recup marche");
        // The 'response' field is a JSON string, parse it
        var nestedResponse = jsonDecode(r['response']);
        // Extract the 'orders' list or adjust as per actual data structure
        return nestedResponse['products'] ?? [];
      } else {
        return [];
      }
    });
  }
}
