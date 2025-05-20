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
        // Directly extract 'products' list from the decoded response map
        return r['products'] ?? [];
      } else {
        return [];
      }
    });
  }
}
