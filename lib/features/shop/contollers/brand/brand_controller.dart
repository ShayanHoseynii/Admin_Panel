import 'package:admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:admin_panel/data/repositories/brands/brands_repository.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/model/brand_model.dart';
import 'package:get/get.dart';

class BrandController extends TBaseController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query);
  }

  @override
  Future<void> deleteItem(BrandModel item) async {
    await _brandRepository.deleteBrand(item);
  }

  @override
  Future<List<BrandModel>> fetchItems() async {
    final fetchedBrands = await _brandRepository.getAllBrands();

    final fetchBrandCategories = await _brandRepository.getAllBrandCategories();

    if (categoryController.allItems.isNotEmpty) await categoryController.fetchItems();
    

    for (var brand in fetchedBrands) {
      List<String> categoryIds = fetchBrandCategories
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();
      brand.brandCategory = categoryController.allItems
          .where((category) => categoryIds.contains(category.id))
          .toList();
    }
    return fetchedBrands;
  }

  void sortByName(int sortIndex, bool ascending) {
    sortByProperty(
        sortIndex, ascending, (BrandModel brand) => brand.name.toLowerCase());
  }
}
