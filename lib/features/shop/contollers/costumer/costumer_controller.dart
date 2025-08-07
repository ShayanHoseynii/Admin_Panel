import 'package:admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:admin_panel/data/repositories/user/user_repository.dart';
import 'package:admin_panel/features/authentication/models/user_model.dart';
import 'package:get/get.dart';

class CustomerController extends TBaseController<UserModel> {
  static CustomerController get instance => Get.find();

  final _customreRepo = Get.put(UserRepository());

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await _customreRepo.deleteUser(item.id ?? '');
  }

  @override
  Future<List<UserModel>> fetchItems() async {
    return await _customreRepo.getAllUsers();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (UserModel o) => o.fullName.toString().toLowerCase());
  }
}
