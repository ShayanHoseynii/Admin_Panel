import 'package:admin_panel/features/shop/screens/category/create_category/responsive_screens/create_category_desktop.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateCategoryDesktop(),
    );
  }
}
