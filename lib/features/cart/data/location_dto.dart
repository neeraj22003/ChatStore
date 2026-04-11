class Place {
  final String address;
  Place({required this.address});
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(address: json['display_name'] ?? '');
  }
}
