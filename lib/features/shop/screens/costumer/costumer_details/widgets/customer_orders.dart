import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_panel/features/shop/contollers/costumer/customer_detail_controller.dart';
import 'package:admin_panel/features/shop/screens/costumer/costumer_details/table/data_table.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerOrders();
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(() {
        if (controller.ordersLoading.value) return const TLoaderAnimation();
        if (controller.allCustomerOrders.isEmpty) {
          return  TAnimationLoaderWidget(
              text: 'No Orders Found', animation: TImages.pencilAnimation);
        }

        final totalAmount = controller.allCustomerOrders.fold(0.0,
            (previousValue, element) => previousValue + element.totalAmount);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Orders',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text.rich(TextSpan(children: [
                  const TextSpan(text: 'Total Spent'),
                  TextSpan(
                    text: '\$${totalAmount.toString()}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.primary),
                  ),
                  TextSpan(
                    text: 'on ${controller.allCustomerOrders.length} orders',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ]))
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TextFormField(
              onChanged: (query) => controller.searchQuery(query),
              decoration: const InputDecoration(
                  hintText: 'Search Orders',
                  prefixIcon: Icon(Iconsax.search_normal)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            const CustomerOrderTable(),
          ],
        );
      }),
    );
  }
}
