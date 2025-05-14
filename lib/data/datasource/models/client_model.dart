import 'package:xml/xml.dart';

class Customer {
  final int id;
  final int idDefaultGroup;
  final int idLang;
  final String firstname;
  final String lastname;
  final String email;
  final String passwd;
  final String secureKey;
  final int idGender;
  final String birthday;
  final bool newsletter;
  final bool optin;
  final bool active;
  final bool isGuest;
  final int idShop;
  final int idShopGroup;
  final DateTime dateAdd;
  final DateTime dateUpd;
  final List<int> groupIds;

  Customer({
    required this.id,
    required this.idDefaultGroup,
    required this.idLang,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.passwd,
    required this.secureKey,
    required this.idGender,
    required this.birthday,
    required this.newsletter,
    required this.optin,
    required this.active,
    required this.isGuest,
    required this.idShop,
    required this.idShopGroup,
    required this.dateAdd,
    required this.dateUpd,
    required this.groupIds,
  });

  /// Factory constructor from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: int.parse(json['id']),
      idDefaultGroup: int.parse(json['id_default_group']),
      idLang: int.parse(json['id_lang']),
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      passwd: json['passwd'],
      secureKey: json['secure_key'],
      idGender: int.parse(json['id_gender']),
      birthday: json['birthday'],
      newsletter: json['newsletter'] == '1',
      optin: json['optin'] == '1',
      active: json['active'] == '1',
      isGuest: json['is_guest'] == '1',
      idShop: int.parse(json['id_shop']),
      idShopGroup: int.parse(json['id_shop_group']),
      dateAdd: DateTime.parse(json['date_add']),
      dateUpd: DateTime.parse(json['date_upd']),
      groupIds: (json['groupIds'] as List<dynamic>).map((e) => int.parse(e.toString())).toList(),
    );
  }

  /// Converts to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_default_group': idDefaultGroup,
      'id_lang': idLang,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'passwd': passwd,
      'secure_key': secureKey,
      'id_gender': idGender,
      'birthday': birthday,
      'newsletter': newsletter ? '1' : '0',
      'optin': optin ? '1' : '0',
      'active': active ? '1' : '0',
      'is_guest': isGuest ? '1' : '0',
      'id_shop': idShop,
      'id_shop_group': idShopGroup,
      'date_add': dateAdd.toIso8601String(),
      'date_upd': dateUpd.toIso8601String(),
      'groupIds': groupIds,
    };
  }

  /// Factory constructor from XML
  factory Customer.fromXml(XmlElement customerXml) {
    List<int> groups = customerXml
        .findAllElements('group')
        .map((e) => int.tryParse(e.getElement('id')?.innerText ?? '') ?? 0)
        .where((id) => id != 0)
        .toList();

    return Customer(
      id: int.parse(customerXml.getElement('id')!.innerText),
      idDefaultGroup: int.parse(customerXml.getElement('id_default_group')!.innerText),
      idLang: int.parse(customerXml.getElement('id_lang')!.innerText),
      firstname: customerXml.getElement('firstname')?.innerText ?? '',
      lastname: customerXml.getElement('lastname')?.innerText ?? '',
      email: customerXml.getElement('email')?.innerText ?? '',
      passwd: customerXml.getElement('passwd')?.innerText ?? '',
      secureKey: customerXml.getElement('secure_key')?.innerText ?? '',
      idGender: int.parse(customerXml.getElement('id_gender')?.innerText ?? '0'),
      birthday: customerXml.getElement('birthday')?.innerText ?? '',
      newsletter: customerXml.getElement('newsletter')?.innerText == '1',
      optin: customerXml.getElement('optin')?.innerText == '1',
      active: customerXml.getElement('active')?.innerText == '1',
      isGuest: customerXml.getElement('is_guest')?.innerText == '1',
      idShop: int.parse(customerXml.getElement('id_shop')?.innerText ?? '1'),
      idShopGroup: int.parse(customerXml.getElement('id_shop_group')?.innerText ?? '1'),
      dateAdd: DateTime.parse(
          customerXml.getElement('date_add')?.innerText ?? '2000-01-01T00:00:00'),
      dateUpd: DateTime.parse(
          customerXml.getElement('date_upd')?.innerText ?? '2000-01-01T00:00:00'),
      groupIds: groups,
    );
  }
}
