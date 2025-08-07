
import 'package:admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banners_dekstop_screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class EditBannersScreen extends StatelessWidget {
  const EditBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: EditBannersDekstopScreen(),);
  }
}