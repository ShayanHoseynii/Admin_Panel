import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/features/shop/contollers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsetsGeometry.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: TSizes.spaceBtwSections),
             Row(
              children: [
                Expanded(
                    child: Obx(
                  () => TDashboardCard(
                    stats: 25,
                    title: 'Sales total',
                    subtitle:
                        '\$${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                    headingIcon: Iconsax.note,
                    headingIconColor: Colors.blue,
                    headingIconBgColor: Colors.blue.withOpacity(0.1),
                  ),
                )),
                SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                    child: Obx(
                    () => TDashboardCard(
                      stats: 15,
                      title: 'Average Order Value',
                      subtitle:
                          '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                      headingIcon: Iconsax.external_drive,
                      headingIconColor: Colors.green,
                      headingIconBgColor: Colors.green.withOpacity(0.1),
                    ),
                  )),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
             Row(
              children: [
                Expanded(
                    child: Obx(
                    () => TDashboardCard(
                      stats: 44,
                      title: 'Total Orders',
                      subtitle:
                          controller.orderController.allItems.length.toString(),
                      headingIcon: Iconsax.box,
                      headingIconColor: Colors.deepPurple,
                      headingIconBgColor: Colors.deepPurple.withOpacity(0.1),
                    ),
                  )),
                SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                    child:Obx(
                    () => TDashboardCard(
                      stats: 2,
                      title: 'Visitors',
                      subtitle: controller.cutomerController.allItems.length
                          .toString(),
                      headingIcon: Iconsax.user,
                      headingIconColor: Colors.deepOrange,
                      headingIconBgColor: Colors.deepOrange.withOpacity(0.1),
                    ),
                  )),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Bar Graph
            const TWeeklySalesGraph(),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Orders
            TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Orders',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const DashboardOrderTable(),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Pie Graph
            const OrderStatusGraph(),
          ],
        ),
      )),
    );
  }
}
