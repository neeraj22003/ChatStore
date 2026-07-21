
/*import 'package:chat_shop/src/features/orders/domain/order_use_cases/save_order_firestore.dart';
import 'package:chat_shop/src/features/orders/domain/orderdomain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('save_user firestore', () async {
    final mockUser = MockUser(
      uid: 'test_user_uid_123',
      email: 'tester@chatshop.com',
    );
    final fakefirestore = FakeFirebaseFirestore();
    final auth = MockFirebaseAuth(signedIn: true,mockUser: mockUser);
    final firestore = FirestoreImpl(fakefirestore, auth);
    final saveorder = SaveOrderFirestore(firestore);
    final order = Orders(
      orderId: '',
      name: 'Test_case',
      phone: '999',
      address: 'home',
      total: '500',
      items: [],
    );
    final result = await saveorder.call(order);
   
    expect(result.isSuccess, true);
  });
}
*/