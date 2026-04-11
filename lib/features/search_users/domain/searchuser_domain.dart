class SearchuserDomain {
  String? profileimage;
  final String name;
  final String address;
  final String email;
  final String phone;
  String chatroonmId;
  String id;
  SearchuserDomain({
    required this.profileimage,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    this.chatroonmId = '',
    this.id = '',
  });

  factory SearchuserDomain.fromJson(Map<String, dynamic> data) {
    return SearchuserDomain(
      profileimage: data['profileimage'],
      name: data['name'],
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
    );
  }
}
