class ProductModel {
  int? productId;
  String? productName;
  String? productDesc;
  String? productImage;
  int? productCount;
  bool? productActive;
  double? productPrice;
  String? productDate;
  int? productCat;
  int? categoriesId;
  String? categoriesName;
  String? categoriesImage;
  String? categoriesDatetime;
  String? reference;
  String? condition;
  String? manufacturer;
  double? weight;
  String? availableNow;
  String? availableLater;
  String? descriptionShort;
  int? additionalShippingCost;
  double? wholesalePrice;
  String? unity;
  List<String>? allImages;

  ProductModel({
    this.productId,
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
    this.reference,
    this.condition,
    this.manufacturer,
    this.weight,
    this.availableNow,
    this.availableLater,
    this.descriptionShort,
    this.additionalShippingCost,
    this.wholesalePrice,
    this.unity,
    this.allImages,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productDesc = json['productDesc'];
    productImage = json['productImage'];
    productCount = json['productCount'];
    productActive = json['productActive'];
productPrice = json['productPrice']?.toDouble();
    productDate = json['productDate'];
    productCat = json['productCat'];
    categoriesId = json['categoriesId'];
    categoriesName = json['categoriesName'];
    categoriesImage = json['categoriesImage'];
    categoriesDatetime = json['categoriesDatetime'];
    reference = json['reference'];
    condition = json['condition'];
    manufacturer = json['manufacturer'];
    weight = json['weight']?.toDouble();
    availableNow = json['available_now'];
    availableLater = json['available_later'];
    descriptionShort = json['description_short'];
    additionalShippingCost = json['additional_shipping_cost'];
    wholesalePrice = json['wholesale_price']?.toDouble();
    unity = json['unity'];
    allImages = json['allImages'] != null ? List<String>.from(json['allImages']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productDesc'] = this.productDesc;
    data['productImage'] = this.productImage;
    data['productCount'] = this.productCount;
    data['productActive'] = this.productActive;
    data['productPrice'] = this.productPrice;
    data['productDate'] = this.productDate;
    data['productCat'] = this.productCat;
    data['categoriesId'] = this.categoriesId;
    data['categoriesName'] = this.categoriesName;
    data['categoriesImage'] = this.categoriesImage;
    data['categoriesDatetime'] = this.categoriesDatetime;
    data['reference'] = this.reference;
    data['condition'] = this.condition;
    data['manufacturer'] = this.manufacturer;
    data['weight'] = this.weight;
    data['available_now'] = this.availableNow;
    data['available_later'] = this.availableLater;
    data['description_short'] = this.descriptionShort;
    data['additional_shipping_cost'] = this.additionalShippingCost;
    data['wholesale_price'] = this.wholesalePrice;
    data['unity'] = this.unity;
    data['allImages'] = this.allImages;
    return data;
  }
}