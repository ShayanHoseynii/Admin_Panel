import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:admin_panel/features/shop/contollers/brand/brand_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/edit_product_controller.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final editProductController = Get.put(EditProductController());

    if (brandController.allItems.isEmpty) {
      brandController.fetchItems();
    }

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brand',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Obx(
            () => brandController.isLoading.value
                ? const TShimmerEffect(width: double.infinity, height: 50)
                : TypeAheadField(
                    builder: (context, controller, focusNode) {
                      return TextFormField(
                        controller: editProductController.brandTextField =
                            controller,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Brand',
                          suffixIcon: Icon(Iconsax.box),
                        ),
                      );
                    },
                    suggestionsCallback: (pattern) {
                      return brandController.allItems
                          .where((brand) => brand.name.contains(pattern))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(title: Text(suggestion.name));
                    },
                    onSelected: (suggestion) {
                      editProductController.selectedBrand.value = suggestion;
                      editProductController.brandTextField.text =
                          suggestion.name;
                    },
                  ),
          )
        ],
      ),
    );
  }
}
