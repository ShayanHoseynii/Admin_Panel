import 'package:admin_panel/data/repositories/user/user_repository.dart';
import 'package:admin_panel/features/authentication/models/user_model.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<UserModel> fetchUserDetails() async{
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    }catch(e){
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
      return UserModel.empty();
    }
  }
}
