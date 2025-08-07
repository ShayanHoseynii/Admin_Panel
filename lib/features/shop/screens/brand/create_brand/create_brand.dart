

import 'package:admin_panel/features/shop/screens/brand/create_brand/responsive_screens/create_brands_desktop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateBrandsDesktopScreen(),);
  }
}