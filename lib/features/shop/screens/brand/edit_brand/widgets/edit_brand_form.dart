import 'package:admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/features/shop/contollers/brand/edit_brand_controller.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/model/brand_model.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditbrandController());
    controller.init(brand);
    final categoryController = Get.put(CategoryController());
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm),
            Text(
              'Edit Brand',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // Name Text Field
            TextFormField(
              controller: controller.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                  labelText: 'Brand Name', prefixIcon: Icon(Iconsax.category)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            // Categories
            Text(
              'Selected Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),
            Obx(
              () => Wrap(
                  spacing: TSizes.sm,
                  children: categoryController.allItems
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: TSizes.sm),
                          child: TChoiceChip(
                            text: item.name,
                            selected:
                                controller.selectedCategories.contains(item),
                            onSelected: (value) =>
                                controller.toggleSelection(item),
                          ),
                        ),
                      )
                      .toList()),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),

            // Image Uploader And Feature CheckBox
            TImageUploader(
              imageType: controller.imageURL.value.isNotEmpty
                  ? ImageType.network
                  : ImageType.asset,
              width: 80,
              height: 80,
              onIconButtonPressed: () => controller.pickImage(),
              image: controller.imageURL.value.isNotEmpty
                  ? controller.imageURL.value
                  : TImages.defaultImage,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
              () => CheckboxMenuButton(
                  value: controller.isFeatured.value,
                  onChanged: (value) =>
                      controller.isFeatured.value = value ?? false,
                  child: const Text('Featured')),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateBrand(brand),
                  child: const Text('Update')),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
          ],
        ),
      ),
    );
  }
}
