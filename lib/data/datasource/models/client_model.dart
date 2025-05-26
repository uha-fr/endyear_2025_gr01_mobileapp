
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
    };
  }
}
