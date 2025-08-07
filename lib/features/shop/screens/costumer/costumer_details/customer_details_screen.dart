import 'package:admin_panel/features/shop/screens/costumer/costumer_details/responsive_screens/customer_detail_desktop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    final customerId = Get.parameters['customerId'];
    return TSiteTemplate(
      desktop: CustomerDetailDesktopScreen(customer: customer),
    );
  }
}
