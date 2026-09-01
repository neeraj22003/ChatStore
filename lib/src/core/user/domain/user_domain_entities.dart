class UserDomain {
  final String id;
  final String? profileimage;
  final String name;
  final String address;
  final String email;
  final String phone;
  final String? password;
  
  UserDomain({
    required this.id,
    required this.profileimage,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    
    this.password,
  });
}
