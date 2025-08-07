

import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/features/authentication/models/user_model.dart';
import 'package:admin_panel/features/shop/screens/costumer/costumer_details/widgets/customer_info.dart';
import 'package:admin_panel/features/shop/screens/costumer/costumer_details/widgets/customer_orders.dart';
import 'package:admin_panel/features/shop/screens/costumer/costumer_details/widgets/shipping_address.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({super.key, required this.customer});
  final UserModel customer;
 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
             TBreadcrumbWithHeading(
              returnToPreviousScreen: true,
              heading: customer.fullName,
              breadcrumbItems:const  [TRoutes.customers, 'Details'],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Body
            CustomerInfo(customer: customer),
            const SizedBox(height: TSizes.spaceBtwSections),
            
            // Shipping Address
            const ShippingAddress(),
            const SizedBox(width: TSizes.spaceBtwSections),
            // Add right side content if needed...

            const CustomerOrders(),
          ],
        ),
      ),
    ),
  );
}
}