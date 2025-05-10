class OrderModel {
  int? id;
  String? reference;
  int? idCart;
  int? idCustomer;
  int? idCurrency;
  int? idAddressDelivery;
  int? idAddressInvoice;
  int? idCarrier;
  int? currentState;
  String? payment;
  String? module;
  double? totalPaid;
  double? totalPaidTaxIncl;
  double? totalPaidTaxExcl;
  double? totalProducts;
  double? totalShipping;
  double? conversionRate;
  DateTime? dateAdd;
  DateTime? dateUpd;
  bool? valid;
  bool? recyclable;
  bool? gift;
  String? giftMessage;

  OrderModel({
    this.id,
    this.reference,
    this.idCart,
    this.idCustomer,
    this.idCurrency,
    this.idAddressDelivery,
    this.idAddressInvoice,
    this.idCarrier,
    this.currentState,
    this.payment,
    this.module,
    this.totalPaid,
    this.totalPaidTaxIncl,
    this.totalPaidTaxExcl,
    this.totalProducts,
    this.totalShipping,
    this.conversionRate,
    this.dateAdd,
    this.dateUpd,
    this.valid,
    this.recyclable,
    this.gift,
    this.giftMessage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      reference: json['reference'],
      idCart: json['idCart'],
      idCustomer: json['idCustomer'],
      idCurrency: json['idCurrency'],
      idAddressDelivery: json['idAddressDelivery'],
      idAddressInvoice: json['idAddressInvoice'],
      idCarrier: json['idCarrier'],
      currentState: json['currentState'],
      payment: json['payment'],
      module: json['module'],
      totalPaid: (json['totalPaid'] as num?)?.toDouble(),
      totalPaidTaxIncl: (json['totalPaidTaxIncl'] as num?)?.toDouble(),
      totalPaidTaxExcl: (json['totalPaidTaxExcl'] as num?)?.toDouble(),
      totalProducts: (json['totalProducts'] as num?)?.toDouble(),
      totalShipping: (json['totalShipping'] as num?)?.toDouble(),
      conversionRate: (json['conversionRate'] as num?)?.toDouble(),
      dateAdd: json['dateAdd'] != null ? DateTime.parse(json['dateAdd']) : null,
      dateUpd: json['dateUpd'] != null ? DateTime.parse(json['dateUpd']) : null,
      valid: json['valid'],
      recyclable: json['recyclable'],
      gift: json['gift'],
      giftMessage: json['giftMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'idCart': idCart,
      'idCustomer': idCustomer,
      'idCurrency': idCurrency,
      'idAddressDelivery': idAddressDelivery,
      'idAddressInvoice': idAddressInvoice,
      'idCarrier': idCarrier,
      'currentState': currentState,
      'payment': payment,
      'module': module,
      'totalPaid': totalPaid,
      'totalPaidTaxIncl': totalPaidTaxIncl,
      'totalPaidTaxExcl': totalPaidTaxExcl,
      'totalProducts': totalProducts,
      'totalShipping': totalShipping,
      'conversionRate': conversionRate,
      'dateAdd': dateAdd?.toIso8601String(),
      'dateUpd': dateUpd?.toIso8601String(),
      'valid': valid,
      'recyclable': recyclable,
      'gift': gift,
      'giftMessage': giftMessage,
    };
  }
}
