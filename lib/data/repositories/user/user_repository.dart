
import 'package:admin_panel/data/repositories/authentication_repository.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:admin_panel/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find<UserRepository>();

  final _db = FirebaseFirestore.instance;
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<UserModel> fetchAdminDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
  Future<UserModel> fetchUserDetails(String id) async {
    try {
      final documentSnapshot = await _db.collection('Users').doc(id).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
Future<List<UserModel>> getAllUsers() async {
    try {
      final documentSnapshot =
          await _db.collection('Users').orderBy('firstName').get();
      return documentSnapshot.docs
          .map((doc) => UserModel.fromSnapshot(doc))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
      final documentSnapshot =
          await _db.collection('Orders').where('userId' , isEqualTo: userId).get();
      return documentSnapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
          await _db.collection('Users').doc(updatedUser.id).update(updatedUser.toJson());

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
          await _db.collection('Users').doc(AuthenticationRepository.instance.authUser!.uid).update(json);

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
Future<void> deleteUser(String id) async {
    try {
          await _db.collection('Users').doc(id).delete();

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> uploaddumyData(UserModel user) async {
    try {
          await _db.collection('Users').add(user.toJson());

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }





}
