


import 'package:admin_panel/features/shop/screens/dashboard/responsive_screens/Dashboard_Desktop_Screen.dart';
import 'package:admin_panel/features/shop/screens/dashboard/responsive_screens/Dashboard_Mobile_Screen.dart';
import 'package:admin_panel/features/shop/screens/dashboard/responsive_screens/Dashboard_Tablet_Screen.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: DashboardDesktopScreen(), tablet: DashboardTabletScreen(), mobile: DashboardMobileScreen(),);
  }
}