import 'package:admin_panel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:admin_panel/features/authentication/screens/login/widgets/login_header.dart';
import 'package:admin_panel/widgets/layouts/templates/TLoginTemplate.dart';
import 'package:flutter/material.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tlogintemplate(
      child: Column(
        children: [
          LoginHeader(),
          LoginForm(),
        ],
      ),
    );
  }
}
