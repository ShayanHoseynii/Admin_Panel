import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/contollers/category/edit_category_controller.dart';
import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    editController.init(category);
    final categoryController = Get.put(CategoryController());

    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.sm),
          Text(
            'Update Category',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          TextFormField(
            controller: editController.name,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: const InputDecoration(
                labelText: 'Category Name', prefixIcon: Icon(Iconsax.category)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          DropdownButtonFormField(
            items: categoryController.allItems
                .map((c) => DropdownMenuItem(
                    value: c,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text(c.name)],
                    )))
                .toList(),
            value: editController.selectedParent.value.id.isNotEmpty
                ? editController.selectedParent.value
                : null,
            onChanged: (newValue) =>
                editController.selectedParent.value = newValue!,
            decoration: const InputDecoration(
              hintText: 'Parent Category',
              labelText: 'Parent Category',
              prefixIcon: Icon(Iconsax.bezier),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
          Obx(
            () => TImageUploader(
              imageType: editController.imageURL.value.isNotEmpty
                  ? ImageType.network
                  : ImageType.asset,
              width: 80,
              height: 80,
              onIconButtonPressed: () => editController.pickImage(),
              image: editController.imageURL.value.isNotEmpty
                  ? editController.imageURL.value
                  : TImages.defaultImage,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => CheckboxMenuButton(
                value: editController.isFeatured.value,
                onChanged: (value) =>
                    editController.isFeatured.value = value ?? false,
                child: const Text('Featured')),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => editController.updateCategory(category),
                child: const Text('Update')),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
        ],
      ),
    );
  }
}
