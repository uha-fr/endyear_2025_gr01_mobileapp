class Employee {
  final int id;
  final String lastname;
  final String firstname;
  final String email;
  final int active;
  final int idProfile;

  Employee({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.email,
    required this.active,
    required this.idProfile,
  });

  /// Factory constructor from JSON
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      lastname: json['lastname'] ?? '',
      firstname: json['firstname'] ?? '',
      email: json['email'] ?? '',
      active: int.tryParse(json['active'].toString()) ?? 0,
      idProfile: int.tryParse(json['id_profile'].toString()) ?? 0,
    );
  }

  /// Converts to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastname': lastname,
      'firstname': firstname,
      'email': email,
      'active': active,
      'id_profile': idProfile,
    };
  }
}
