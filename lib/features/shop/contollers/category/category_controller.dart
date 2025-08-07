import 'package:admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:admin_panel/data/repositories/category/category_repository.dart';
import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends TBaseController<CategoryModel> {
  static CategoryController get instance => Get.find();


  final _categoryRepository = Get.put(CategoryRepository());

    @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CategoryModel item) async {
    await _categoryRepository.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async {
    return await _categoryRepository.getAllCategories();
  }

  void sortByName(int sortIndex, bool ascending) {
    sortByProperty(sortIndex, ascending,
        (CategoryModel category) => category.name.toLowerCase());
  }
}
