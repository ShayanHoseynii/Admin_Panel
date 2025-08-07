import 'package:admin_panel/features/shop/screens/order/oder_details/responsive_screens/order_details_desktop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class OrderDatailsScreen extends StatelessWidget {
  const OrderDatailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return TSiteTemplate(
      desktop: OrderDetailsDesktopScreen(order: order),
    );
  }
}
