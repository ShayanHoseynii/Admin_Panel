
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/features/shop/contollers/product/create_product_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_image_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_variation_controller.dart';
import 'package:admin_panel/features/shop/model/product_variation_model.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ProductVariation extends StatelessWidget {
  const ProductVariation({super.key});

  @override
  Widget build(BuildContext context) {
    final variationController = ProductVariationController.instance;
    return Obx(
      () => CreateProductController.instance.productType.value ==
              ProductType.variable
          ? TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product variation Header
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Variations',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        TextButton(
                            onPressed: () =>
                                variationController.removeVariations(context),
                            child: const Text('Remove Variations')),
                      ]),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  // Variation List
                  if (variationController.productVariations.isNotEmpty)
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          final variation =
                              variationController.productVariations[index];
                          return _buildVariationTile(
                              context, index, variation, variationController);
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                        itemCount: variationController.productVariations.length)

                  // NO variation Message
                  else
                    _buildNoVariationsMessage(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildVariationTile(
      BuildContext context,
      int index,
      ProductVariationModel variation,
      ProductVariationController variationController) {
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: const EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      title: Text(variation.attributeValues.entries
          .map((e) => '${e.key}: ${e.value}')
          .join(', ')),
      children: [
        // Upload Variation Image
        Obx(
          () => TImageUploader(
            right: 0,
            left: null,
            imageType: variation.image.value.isNotEmpty
                ? ImageType.network
                : ImageType.asset,
            image: variation.image.value.isNotEmpty
                ? variation.image.value
                : TImages.defaultImage,
            onIconButtonPressed: () {
              ProductImageController.instance.selectVariationImage(variation);
            },
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Variation Stock and Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.stock = int.parse(value),
                controller: variationController.stockControllersList[index]
                    [variation],
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers are allowed',
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.price = double.parse(value),
                controller: variationController.priceControllersList[index]
                    [variation],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter price',
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.salePrice = double.parse(value),
                controller: variationController.salePriceControllersList[index]
                    [variation],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Discount Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
          ],
        ),

        TextFormField(
          onChanged: (value) => variation.description = value,
          controller: variationController.descriptionControllersList[index]
              [variation],
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Add desciption of this variation...',
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections)
      ],
    );
  }
}

_buildNoVariationsMessage() {
  return const Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TRoundedImage(
            imageType: ImageType.asset,
            width: 200,
            height: 200,
            image: TImages.defaultVariationImageIcon,
          )
        ],
      ),
      SizedBox(
        height: TSizes.spaceBtwItems,
      ),
      Text('There are no Vatiations added for this products')
    ],
  );
}
