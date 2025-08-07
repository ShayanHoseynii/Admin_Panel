import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //firebase auth instance
  final _auth = FirebaseAuth.instance;

  // get ated user data
  User? get authUser => _auth.currentUser;

  //Get Isated User
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
  }

  void screenRedirect() {
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAllNamed(TRoutes.dashboard);
    } else {
      Get.offAllNamed(TRoutes.login);
    }
  }

  //Login
  Future<UserCredential> loginWithEmailPassword(
      String email, String password) async {
    try {
      return await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return value;
      });
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  //register
  Future<UserCredential> registerWithEmailPassword(
      String email, String password) async {
    try {
      return await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return value;
      });
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

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(TRoutes.login);
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
