import 'package:admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return TSiteTemplate(
      desktop: EditCategoryDesktop(category: category),
    );
  }
}
