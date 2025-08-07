

import 'package:admin_panel/features/shop/screens/order/all_orders/responsive_screens/orders_desktop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: OrdersDesktopScreen(),);
  }
}