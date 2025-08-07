import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/features/shop/contollers/product/create_product_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_attribute_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_variation_controller.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = CreateProductController.instance;
    final attributeController = Get.put(ProductAttributesController());
    final variationController = Get.put(ProductVariationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return productController.productType.value == ProductType.single
              ? const Column(
                  children: [
                    Divider(color: TColors.primaryBackground),
                    SizedBox(height: TSizes.spaceBtwSections),
                  ],
                )
              : const SizedBox.shrink();
        }),

        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Form to add Attributes
        Form(
            key: attributeController.attributeFormKey,
            child: TDeviceUtils.isDesktopScreen(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildAttributeName(attributeController)),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Expanded(
                          flex: 2,
                          child: _buildAttributes(attributeController)),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      _buildAddAttributeButton(attributeController),
                    ],
                  )
                : Column(children: [
                    _buildAttributeName(attributeController),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    _buildAttributes(attributeController),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    _buildAddAttributeButton(attributeController),
                  ])),

        // List of added Attributes
        Text(
          'All Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        // Displaying the added variables in a container
        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Obx(() {
            if (attributeController.productAttributes.isEmpty) {
              return buildEmptyAttributes();
            } else {
              return buildAttributeList(context, attributeController);
            }
          }),
        ),

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        Obx(
          () => productController.productType.value == ProductType.variable &&
                  variationController.productVariations.isEmpty
              ? Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      onPressed: () => variationController
                          .generateVariationsConfirmation(context),
                      label: const Text('Generate Variations'),
                      icon: const Icon(Iconsax.activity),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  Widget _buildAddAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
          onPressed: () => controller.addNewAttribute(),
          icon: const Icon(Iconsax.add),
          style: ElevatedButton.styleFrom(
              foregroundColor: TColors.black,
              backgroundColor: TColors.secondary,
              side: const BorderSide(color: TColors.secondary)),
          label: const Text('add')),
    );
  }

  Widget _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) =>
          TValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
          labelText: 'Attribute Name', hintText: 'Colors, Sizes, Material'),
    );
  }

  SizedBox _buildAttributes(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        controller: controller.attributes,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            TValidator.validateEmptyText('Attributes Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText:
              'Add attributes separated by | Example: Green | Blue | Yellow',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget buildAttributeList(
      BuildContext context, ProductAttributesController controller) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                color: TColors.white,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
            child: ListTile(
              title: Text(controller.productAttributes[index].name ?? ''),
              subtitle: Text(controller.productAttributes[index].values!
                  .map((e) => e.trim())
                  .toString()),
              trailing: IconButton(
                  onPressed: () => controller.removeAttribute(index, context),
                  icon: const Icon(
                    Iconsax.trash,
                    color: TColors.error,
                  )),
            ),
          );
        },
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemCount: controller.productAttributes.length);
  }

  Widget buildEmptyAttributes() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: TImages.defaultAttributeColorsImageIcon,
            ),
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text('There are no attributes added for this product'),
      ],
    );
  }
}
