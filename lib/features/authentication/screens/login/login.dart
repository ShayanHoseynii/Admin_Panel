import 'package:admin_panel/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:admin_panel/features/authentication/screens/login/responsive_screens/loing_desktop_tablet.dart';
import 'package:admin_panel/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false, desktop: LoginScreenDesktopTablet(),mobile: LoginScreenMobile(),);
  }
}