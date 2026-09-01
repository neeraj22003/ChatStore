import 'package:chat_shop/src/features/chats/domain/chat_user_domain.dart';
import 'package:chat_shop/src/features/search_users/domain/searchuser_domain.dart';

class SearchuserDto {
  final String profileimage;
  final String name;
  final String address;
  final String email;
  final String phone;

  final String id;
  SearchuserDto({
    required this.id,
    required this.profileimage,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });

  factory SearchuserDto.fromJson(Map<String, dynamic> data) {
    return SearchuserDto(
      id: data['id'] ?? '',
      profileimage: data['profileimage']??'',
      name: data['name']??'',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

  SearchuserDomain touserDomain() {
    return SearchuserDomain(
      id: id,
      profileimage: profileimage,
      name: name,
      address: address,
      email: email,
      phone: phone,
    );
  }

  ChatUserDomain tochatDomain() {
    return ChatUserDomain(id, name, email, profileimage);
  }
}
