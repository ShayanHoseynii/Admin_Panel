
import 'package:admin_panel/data/repositories/user/user_repository.dart';
import 'package:admin_panel/features/authentication/models/user_model.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  static OrderDetailController get instance => Get.find();

  RxBool loading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  /// -- Load customer of current order
  Future<void> getCustomerOfCurrentOrder(String userId) async {
    try {
      // Show loader while fetching
      loading.value = true;

      // Fetch customer details based on order's userId
      final user = await UserRepository.instance.fetchUserDetails(userId);
      customer.value = user;
      
      // Check if user exists and has valid data
      if (user.email.isEmpty) {
        print('User not found for userId: $userId');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
