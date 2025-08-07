import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/features/shop/contollers/product/create_product_controller.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());

    return TRoundedContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Title
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            TextFormField(
              controller: controller.title,
              validator: (value) =>
                  TValidator.validateEmptyText('Product Title', value),
              decoration: const InputDecoration(labelText: 'Product Title'),
            ),

            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            SizedBox(
              height: 300,
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: controller.description,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) =>
                    TValidator.validateEmptyText('Product Description', value),
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  hintText: 'Add your Product Description here...',
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
