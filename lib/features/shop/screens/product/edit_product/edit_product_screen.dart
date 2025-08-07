import 'package:admin_panel/features/shop/contollers/product/edit_product_controller.dart';
import 'package:admin_panel/features/shop/screens/product/edit_product/responsive_screens/Edit_product_dektop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    
    // Initialize the controller with product data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initProductData(product);
    });
    
    return TSiteTemplate(
      desktop: EditProductDektopScreen(product: product),
    );
  }
}
