


import 'package:admin_panel/features/shop/screens/banner/create_banner/responsive_screens/create_banners_dekstop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class CreateBannersScreen extends StatelessWidget {
  const CreateBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateBannersDekstopScreen(),);
  }
}