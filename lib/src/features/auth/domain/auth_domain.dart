import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';

class AuthDomain {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? address;
  final String? phone;
  final String? profile;
  AuthDomain({
    this.id,
    this.email,
    this.password,
    this.name,
    this.address,
    this.phone,
    this.profile
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
    return {'id':id,'name': name, 'email': email, 'address': address, 'phone': phone};
  }

  UserDomain toUser() {
    return UserDomain(
      id: 'MHxOKSBan2dzj60RFo1kwpzl0tq2',
      name: name!,
      email: email!,
      address: address!,
      phone: phone!,
      profileimage: null,
    );
  }
}
