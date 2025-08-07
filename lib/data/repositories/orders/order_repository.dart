import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getAllOrders() async {
    try {
      final snapshot = await _db.collection('Orders').orderBy('orderDate', descending: true).get();

      final result = snapshot.docs.map((doc) {
        try {
          return OrderModel.fromSnapshot(doc);
        } catch (e) {
          print('Error parsing order ${doc.id}: $e');
          return null;
        }
      }).whereType<OrderModel>().toList();

      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  Future<void> deleteOrder(String id) async {
    try {
      await _db.collection('Orders').doc(id).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> addOrder(OrderModel order) async {
    try {
      final data = await _db.collection('Orders').add(order.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateOrderSpecificValue(
      String orderId, Map<String, dynamic> data) async {
    try {
      await _db.collection('Orders').doc(orderId).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
