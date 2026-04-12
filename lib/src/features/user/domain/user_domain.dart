class UserDomain {
  String? profileimage;
  final String name;
  final String address;
  final String email;
  final String phone;

  UserDomain({
    required this.profileimage,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });

  factory UserDomain.fromJson(Map<String, dynamic> data) {
    return UserDomain(
      profileimage: data['profileimage'],
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'query': name.toLowerCase().trim(),

      'profileimage': profileimage,
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
    };
  }
}
