import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/contollers/category/create_category_controller.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());

    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.sm),
          Text(
            'Creat New Category',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Name Text Field
          TextFormField(
            controller: createController.name,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: const InputDecoration(
                labelText: 'Category Name', prefixIcon: Icon(Iconsax.category)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => categoryController.isLoading.value
                ? const TShimmerEffect(width: double.infinity, height: 55)
                : DropdownButtonFormField(
                    items: categoryController.allItems
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [Text(item.name)],
                            )))
                        .toList(),
                    onChanged: (newValue) =>
                        createController.selectedParent.value = newValue!,
                    decoration: const InputDecoration(
                      hintText: 'Parent Category',
                      labelText: 'Parent Category',
                      prefixIcon: Icon(Iconsax.bezier),
                    ),
                  ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
          Obx(
            () => TImageUploader(
              imageType: createController.imageURL.value.isNotEmpty
                  ? ImageType.network
                  : ImageType.asset,
              width: 80,
              height: 80,
              onIconButtonPressed: () => createController.pickImage(),
              image: createController.imageURL.value.isNotEmpty
                  ? createController.imageURL.value
                  : TImages.defaultImage,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => CheckboxMenuButton(
                value: createController.isFeatured.value,
                onChanged: (value) =>
                    createController.isFeatured.value = value ?? false,
                child: const Text('Featured')),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => createController.createCategory(),
                child: const Text('Create')),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
        ],
      ),
    );
  }
}
