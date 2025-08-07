

import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTransaction extends StatelessWidget {
  const OrderTransaction({super.key, required this.order});
final OrderModel order;

@override
Widget build(BuildContext context) {
  return TRoundedContainer(
    padding: const EdgeInsets.all(TSizes.defaultSpace),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transactions',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        Row(
          children: [
            Expanded(
              flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
              child: Row(
                children: [
                  const TRoundedImage(
                    imageType: ImageType.asset,
                    image: TImages.paypal,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment via ${order.paymentMethod.toString().capitalize}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '${order.paymentMethod.toString().capitalize} fee \$25',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'April 21, 2025',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    '\$${order.totalAmount}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

}