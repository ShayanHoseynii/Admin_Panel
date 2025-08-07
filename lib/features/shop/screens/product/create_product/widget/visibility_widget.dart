import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Visibility',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          Column(
            children: [
              _buildVisibilityButton(ProductVisibility.published, 'Published'),
              _buildVisibilityButton(ProductVisibility.published, 'Hidden'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildVisibilityButton(ProductVisibility value, String label) {
    return RadioMenuButton<ProductVisibility>(
        value: value,
        groupValue: ProductVisibility.published,
        onChanged: (selection) {},
        child: Text(label));
  }
}
