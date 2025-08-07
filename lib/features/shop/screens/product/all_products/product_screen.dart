
import 'package:admin_panel/features/shop/screens/product/all_products/responsive_screens/product_dektop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const  TSiteTemplate(desktop: ProductDektopScreen(),);
  }
}