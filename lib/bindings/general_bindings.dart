import 'package:admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:admin_panel/features/media/repository/media_repository.dart';
import 'package:admin_panel/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => MediaRepository(), fenix: true);
  }
}
