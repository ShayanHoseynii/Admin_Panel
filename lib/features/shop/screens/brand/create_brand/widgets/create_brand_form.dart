import 'package:admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/features/shop/contollers/brand/create_brand_controller.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
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
              'Create New Brand',
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
              'Select Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),
            Obx(
              () => Wrap(
                spacing: TSizes.sm,
                children: Get.put(CategoryController()).allItems
                .map((category) => Padding(
                    padding: const EdgeInsets.only(bottom: TSizes.sm),
                    child: TChoiceChip(
                      text: category.name,
                      selected: controller.selectedCategories.contains(category),
                      onSelected: (value) => controller.toggleSelection(category),
                    ),
                  ),).toList(),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),

            // Image Uploader And Feature CheckBox
            Obx(
            ()=> TImageUploader(
                imageType: controller.imageURL.value.isNotEmpty? ImageType.network : ImageType.asset,
                width: 80,
                height: 80,
                onIconButtonPressed: () => controller.pickImage(),
                image: controller.imageURL.value.isNotEmpty? controller.imageURL.value : TImages.defaultImage,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
              ()=> CheckboxMenuButton(
                  value: controller.isFeatured.value,
                  onChanged: (value) => controller.isFeatured.value = value ?? false,
                  child: const Text('Featured')),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields * 2,
            ),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () => controller.createBrand(), child: const Text('Create')),
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
