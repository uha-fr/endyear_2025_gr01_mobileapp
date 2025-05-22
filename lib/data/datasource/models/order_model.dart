class Address {
  final String address1;
  final String address2;
  final String postcode;
  final String city;
  final String country;

  Address({
    required this.address1,
    required this.address2,
    required this.postcode,
    required this.city,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      postcode: json['postcode'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
    );
  }
}

class OrderModel {
  final int id;
  final String reference;
  final int idCustomer;
  final String customerName;
  final String currentStateName;
  final String payment;
  final String module;
  final double totalPaidTaxIncl;
  final String dateAdd;
  final String dateUpd;
  final bool valid;
  final bool recyclable;
  final bool gift;
  final String giftMessage;
  final Address deliveryAddress;
  final Address invoiceAddress;

  OrderModel({
    required this.id,
    required this.reference,
    required this.idCustomer,
    required this.customerName,
    required this.currentStateName,
    required this.payment,
    required this.module,
    required this.totalPaidTaxIncl,
    required this.dateAdd,
    required this.dateUpd,
    required this.valid,
    required this.recyclable,
    required this.gift,
    required this.giftMessage,
    required this.deliveryAddress,
    required this.invoiceAddress,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      reference: json['reference'] ?? '',
      idCustomer: json['idCustomer'] ?? 0,
      customerName: json['customerName'] ?? '',
      currentStateName: json['currentStateName'] ?? '',
      payment: json['payment'] ?? '',
      module: json['module'] ?? '',
      totalPaidTaxIncl: (json['totalPaidTaxIncl'] as num?)?.toDouble() ?? 0.0,
      dateAdd: json['dateAdd'] ?? '',
      dateUpd: json['dateUpd'] ?? '',
      valid: json['valid'] ?? false,
      recyclable: json['recyclable'] ?? false,
      gift: json['gift'] ?? false,
      giftMessage: json['giftMessage'] ?? '',
      deliveryAddress: Address.fromJson(json['deliveryAddress'] ?? {}),
      invoiceAddress: Address.fromJson(json['invoiceAddress'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, reference: $reference, customerName: $customerName, currentStateName: $currentStateName, totalPaidTaxIncl: $totalPaidTaxIncl)';
  }
}
