


import 'package:admin_panel/features/shop/screens/banner/all_banners/responsive_screens/banners_dekstop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: BannersDekstopScreen(),);
  }
}