

import 'package:admin_panel/features/shop/screens/brand/all_brands/responsive_screens/brands_desktop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: BrandsDesktopScreen(),);
  }
}