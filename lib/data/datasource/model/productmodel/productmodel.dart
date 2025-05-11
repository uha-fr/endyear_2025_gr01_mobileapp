
class ProductModel {
  String? productId;
  String? productName;
  String? productDesc;
  String? productImage;
  String? productCount;
  String? productActive;
  String? productPrice;
  String? productDate;
  String? productCat;
  String? categoriesId;
  String? categoriesName;
  String? categoriesImage;
  String? categoriesDatetime;

  ProductModel(
      {this.productId,
        this.productName,
        this.productDesc,
        this.productImage,
        this.productCount,
        this.productActive,
        this.productPrice,
        this.productDate,
        this.productCat,
        this.categoriesId,
        this.categoriesName,
        this.categoriesImage,
        this.categoriesDatetime,
        });

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productDesc = json['product_desc'];
    productImage = json['product_image'];
    productCount = json['product_count'];
    productActive = json['product_active'];
    productPrice = json['product_price'];
    productDate = json['product_date'];
    productCat = json['product_cat'];
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesImage = json['categories_image'];
    categoriesDatetime = json['categories_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_desc'] = this.productDesc;
    data['product_image'] = this.productImage;
    data['product_count'] = this.productCount;
    data['product_active'] = this.productActive;
    data['product_price'] = this.productPrice;
    data['product_date'] = this.productDate;
    data['product_cat'] = this.productCat;
    data['categories_id'] = this.categoriesId;
    data['categories_name'] = this.categoriesName;
    data['categories_image'] = this.categoriesImage;
    data['categories_datetime'] = this.categoriesDatetime;
    return data;
  }
}