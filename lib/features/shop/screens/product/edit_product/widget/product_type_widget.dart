import 'package:admin_panel/features/shop/contollers/product/create_product_controller.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return Obx(
      () => Row(
        children: [
          Text(
            'Product Type',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          RadioMenuButton(
              value: ProductType.single,
              groupValue: controller.productType.value,
              onChanged: (value) {
                controller.productType.value = value ?? ProductType.single;
              },
              child: const Text('Single')),
          RadioMenuButton(
              value: ProductType.variable,
              groupValue: controller.productType.value,
              onChanged: (value) {
                controller.productType.value = value ?? ProductType.single;
              },
              child: const Text('Variable')),
        ],
      ),
    );
  }
}
