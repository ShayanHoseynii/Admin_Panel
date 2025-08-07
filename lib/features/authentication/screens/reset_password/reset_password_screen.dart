import 'package:admin_panel/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:admin_panel/features/authentication/screens/reset_password/responsive_screens/reset_password_mobile.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false, desktop: ResetPasswordDesktopTablet(), mobile: ResetPasswordMobile(),);
  }
}