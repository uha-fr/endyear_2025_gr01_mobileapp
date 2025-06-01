class Address {
  final int id;
  final String address1;
  final String? address2;
  final String postcode;
  final String city;
  final String country;
  final String phone;

  Address({
    required this.id,
    required this.address1,
    this.address2,
    required this.postcode,
    required this.city,
    required this.country,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      address1: json['address1'] ?? '',
      address2: json['address2'],
      postcode: json['postcode'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address1': address1,
      'address2': address2,
      'postcode': postcode,
      'city': city,
      'country': country,
      'phone': phone,
    };
  }
}

class Customer {
  final int id;
  final String lastname;
  final String firstname;
  final String email;
  final String? gender;
  final String? birthday;
  final int? active;
  final String dateAdd;
  final String? dateUpd;
  final List<int>? orderIds;
  final List<Address>? addresses;

  Customer({
    required this.id,
    required this.lastname,
    required this.firstname,
    this.email = '',
    this.gender,
    this.birthday,
    this.active,
    required this.dateAdd,
    this.dateUpd,
    this.orderIds,
    this.addresses,
  });

  /// Factory constructor from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      lastname: json['lastname'] ?? '',
      firstname: json['firstname'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'],
      birthday: json['birthday'],
      active: json['active'],
      dateAdd: json['date_add'] ?? '',
      dateUpd: json['date_upd'],
      orderIds:
          json['order_ids'] != null
              ? (json['order_ids'] as List<dynamic>)
                  .map((e) => e as int)
                  .toList()
              : null,
      addresses:
          json['addresses'] != null
              ? (json['addresses'] as List<dynamic>)
                  .map((e) => Address.fromJson(e))
                  .toList()
              : null,
    );
  }

  /// Converts to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastname': lastname,
      'firstname': firstname,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'active': active,
      'date_add': dateAdd,
      'date_upd': dateUpd,
      'order_ids': orderIds,
      'addresses': addresses?.map((e) => e.toJson()).toList(),
    };
  }
}
