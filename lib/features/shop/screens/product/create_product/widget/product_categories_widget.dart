import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/create_product_controller.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductCategoriesWidget extends StatelessWidget {
  const ProductCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.put(CategoryController());

    if (categoriesController.allItems.isEmpty) {
      categoriesController.fetchItems();
    }
    return TRoundedContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Obx(
          () => categoriesController.isLoading.value
              ? const TShimmerEffect(width: double.infinity, height: 50)
              : MultiSelectDialogField(
                  buttonText: const Text('Select Categories'),
                  title: const Text('Categories'),
                  items: categoriesController.allItems
                      .map((c) => MultiSelectItem(c, c.name))
                      .toList(),
                  onConfirm: (values) {
                    CreateProductController.instance.selectedCategories
                        .assignAll(values);
                  },
                  listType: MultiSelectListType.CHIP,
                ),
        )
      ],
    ));
  }
}
