import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  final String orderId;
  final String name;
  final String phone;
  final String address;
  final String total;
  final List<Map<String, dynamic>> items;
  Orders({
    required this.orderId,
    required this.name,
    required this.phone,
    required this.address,
    required this.total,
    required this.items,
  });
  factory Orders.fromdoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Orders(
      orderId: doc.id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      total: data['total'] ?? '',
      items: List<Map<String, dynamic>>.from(data['items'] ?? []),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'items': items,
      'total': total,
      'createdAT': FieldValue.serverTimestamp(),
    };
  }
}
