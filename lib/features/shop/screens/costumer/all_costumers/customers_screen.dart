import 'package:admin_panel/features/shop/screens/costumer/all_costumers/responsive_screen/customers_desktop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CustomersDesktopScreen(),);
  }
}