import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/features/shop/screens/order/oder_details/widgets/customer_info.dart';
import 'package:admin_panel/features/shop/screens/order/oder_details/widgets/order_info.dart';
import 'package:admin_panel/features/shop/screens/order/oder_details/widgets/order_items.dart';
import 'package:admin_panel/features/shop/screens/order/oder_details/widgets/order_transasaction.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderDetailsDesktopScreen extends StatelessWidget {
  const OrderDetailsDesktopScreen({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbWithHeading(
                heading: order.id,
                breadcrumbItems: const [TRoutes.orders, 'Details'],
                returnToPreviousScreen: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        OrderInfo(order: order),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        OrderItems(order: order),
                        const SizedBox(height: TSizes.spaceBtwSections,),

                        OrderTransaction(order: order)
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      OrderCustomer(order: order),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      )
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
