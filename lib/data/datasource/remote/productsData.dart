import 'dart:convert';

import '../../../core/class/crud.dart';
import '../../../linkapi.dart';
import '../models/productmodel.dart';

class ProductsData {
  Crud crud;
  ProductsData(this.crud);

  Future<List> getData() async {
    var response = await crud.getData(LinkApi.products);
    return response.fold((l) => [], (r) {
      if (r['success'] == true) {
        // Directly extract 'products' list from the decoded response map
        return r['products'] ?? [];
      } else {
        return [];
      }
    });
  }

  Future<ProductModel?> getProductDetails(int id) async {
    var response = await crud.getData('${LinkApi.productDetails}?id=$id');
    return response.fold((l) => null, (r) {
      if (r['success'] == true) {
        var product = r['product'] ?? r['order'] ?? r;
        return ProductModel.fromJson(product);
      } else {
        return null;
      }
    });
  }
}
