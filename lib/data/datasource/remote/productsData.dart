import 'dart:convert';

import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/productmodel.dart';

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

  Future<ProductModel?> getProductDetails(int id) async {
    print("Link:  ${LinkApi.productDetails}?id=$id");
    var response = await crud.getData('${LinkApi.productDetails}?id=$id');
    print("produit details --- $response");
    return response.fold((l) => null, (r) {
      if (r['success'] == true) {
        var product = r['product'] ?? r['order'] ?? r;
        print('ProductsData: success true, parsing productJson');
        return ProductModel.fromJson(product);
      } else {
        print('ProductsData: success false in response');
        return null;
      }
    });
  }
}
