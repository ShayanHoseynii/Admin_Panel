import 'package:admin_panel/data/repositories/authentication_repository.dart';
import 'package:admin_panel/data/repositories/user/user_repository.dart';
import 'package:admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:admin_panel/features/authentication/models/user_model.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/helpers/network_manager.dart';
import 'package:admin_panel/utils/popups/full_screen_loader.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.docerAnimation);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      await AuthenticationRepository.instance
          .loginWithEmailPassword(email.text.trim(), password.text.trim());

      final user = await UserController.instance.fetchUserDetails();

      TFullScreenLoader.stopLoading();
      print('User details: ${user.toJson()}');

      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(
          title: 'Access Denied',
          message: 'You do not have permission to access this admin panel.',
        );
      } else {
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> registerAdmin() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Register Admin Account...', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .registerWithEmailPassword("shayan@gmail.com", "admin1234");

      final userRepository = Get.put(UserRepository());
      userRepository.createUser(UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          email: 'shayan@gmail.com',
          role: AppRole.admin,
          firstName: 'sayan',
          lastName: 'ghori',
          createdAt: DateTime.now()));

      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      print('GENERIC ERROR: $e');
      throw Exception('Login failed: $e');
    }
  }
}
