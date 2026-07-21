import 'package:chat_shop/src/core/user/domain/user_domain_entities.dart';

class UserDto {
  final String id;
  final String? profileimage;
  final String name;
  final String address;
  final String email;
  final String phone;
  UserDto({
    required this.id,
    this.profileimage,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });

  factory UserDto.fromJson(Map<String, dynamic> data) {
    return UserDto(
      id: data['id']??'',
      profileimage: data['profileimage'],
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'query': name.toLowerCase().trim(),

      'profileimage': profileimage,
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
    };
  }

  UserDomain toDomain() {
    return UserDomain(
      id: id,
      profileimage: profileimage,
      name: name,
      address: address,
      email: email,
      phone: phone,
    );
  }
}
