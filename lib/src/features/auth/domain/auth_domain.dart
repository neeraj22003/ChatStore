class AuthDomain {
  final String? name;
  final String? email;
  final String? password;
  final String? address;
  final String? phone;
  AuthDomain({
    required this.email,
     this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory AuthDomain.fromJson(Map<String, dynamic> json) {
    return AuthDomain(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'address': address, 'phone': phone};
  }
}
