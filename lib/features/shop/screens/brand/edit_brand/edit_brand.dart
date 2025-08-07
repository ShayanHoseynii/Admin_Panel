import 'package:admin_panel/features/shop/screens/brand/edit_brand/responsive_screens/edit_brand_desktop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return TSiteTemplate(
      desktop: EditBrandDesktopScreen(brand: brand),
    );
  }
}
