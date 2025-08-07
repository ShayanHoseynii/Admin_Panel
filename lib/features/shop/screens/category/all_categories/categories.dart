import 'package:admin_panel/features/shop/screens/category/all_categories/responsive_screens/categories_desktop.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CategoriesDesktopScreen());
  }
}
