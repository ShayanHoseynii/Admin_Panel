import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:admin_panel/features/shop/model/product_category.dart';
import 'package:admin_panel/features/shop/model/product_model.dart';
import 'package:admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      final result =
          snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection('Products').doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception('Product Not Found');
        }

        final productCategorySnapshot = await _db
            .collection('ProductCategory')
            .where('productId', isEqualTo: product.id)
            .get();
        final productCategories = productCategorySnapshot.docs
            .map((e) => ProductCategoryModel.fromSnapshot(e));

        if (productCategories.isNotEmpty) {
          for (var productCategory in productCategories) {
            transaction.delete(
                _db.collection('ProductCategory').doc(productCategory.id));
          }
        }
        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<String> createProduct(ProductModel product) async {
    try {
      final data = await _db.collection('Products').add(product.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      final data = await _db
          .collection('Products')
          .doc(product.id)
          .update(product.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<String> createProductCategory(
      ProductCategoryModel productCategory) async {
    try {
      final result =
          await _db.collection('ProductCategory').add(productCategory.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductCategoryModel>> getProductCategories(
      String productId) async {
    try {
      final snapshot = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: productId)
          .get();

      return snapshot.docs
          .map((querysnapshot) =>
              ProductCategoryModel.fromSnapshot(querysnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> removeProductCategory(String id, String categoryId) async {
    try {
      final result = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: categoryId)
          .get();
      for (final doc in result.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
