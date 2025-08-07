
import 'package:admin_panel/features/shop/screens/product/create_product/responsive_screens/create_product_dektop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateProductDektopScreen(),);
  }
}