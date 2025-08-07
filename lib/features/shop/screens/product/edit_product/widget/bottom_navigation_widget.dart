import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/features/shop/contollers/product/edit_product_controller.dart';
import 'package:admin_panel/features/shop/model/product_model.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(onPressed: () {}, child: const Text('Discard')),
          const SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),
          SizedBox(
            width: 160,
            child: ElevatedButton(
                onPressed: () =>
                    EditProductController.instance.editProduct(product),
                child: const Text('Save Changes')),
          )
        ],
      ),
    );
  }
}
