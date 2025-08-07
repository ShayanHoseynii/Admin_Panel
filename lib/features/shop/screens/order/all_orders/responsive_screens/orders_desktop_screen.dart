import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/data_table/table_header.dart';
import 'package:admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_panel/data/repositories/orders/order_repository.dart';
import 'package:admin_panel/features/shop/contollers/order/order_controller.dart';
import 'package:admin_panel/features/shop/screens/order/all_orders/table/data_table.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Get.put(OrderRepository());
    final controller = Get.put(OrderController());
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBreadcrumbWithHeading(
                heading: 'Orders', breadcrumbItems: ['Orders']),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            TRoundedContainer(
                child: Column(
              children: [
                TTableHeader(
                  searchController: controller.searchTextController,
                  searchOnChanged: (query) => controller.searchQuery(query),
                  showLeftWidget: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const TLoaderAnimation();
                  }
                  return const OrderTable();
                }),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
