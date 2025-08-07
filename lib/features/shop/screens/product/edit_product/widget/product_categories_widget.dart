import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/edit_product_controller.dart';
import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:admin_panel/features/shop/model/product_model.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductCategoriesWidget extends StatelessWidget {
  const ProductCategoriesWidget({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(EditProductController());

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
        FutureBuilder(
          future: productController.loadSelectedCategories(product.id),
          builder: (context, snapshot) {
            final widget =
                TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
            if (widget != null) return widget;
            return MultiSelectDialogField(
              buttonText: const Text('Select Categories'),
              title: const Text('Categories'),
              items: CategoryController.instance.allItems
                  .map((c) => MultiSelectItem(c, c.name))
                  .toList(),
              initialValue: List<CategoryModel>.from(productController.selectedCategories),
              onConfirm: (values) {
                EditProductController.instance.selectedCategories
                    .assignAll(values);
              },
              listType: MultiSelectListType.CHIP,
            );
          },
        ),
      ],
    ));
  }
}
