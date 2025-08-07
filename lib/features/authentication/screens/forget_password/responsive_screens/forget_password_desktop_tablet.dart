import 'package:admin_panel/features/authentication/screens/forget_password/widgets/header_form.dart';
import 'package:admin_panel/widgets/layouts/templates/TLoginTemplate.dart';
import 'package:flutter/material.dart';

class ForgetPasswordDesktopTablet extends StatelessWidget {
  const ForgetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Tlogintemplate(
        child: HeaderAndForm());
  }
}
