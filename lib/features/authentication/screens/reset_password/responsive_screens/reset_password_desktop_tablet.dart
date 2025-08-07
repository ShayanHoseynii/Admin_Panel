import 'package:admin_panel/features/authentication/screens/reset_password/widgets/reset_password.dart';

import 'package:admin_panel/widgets/layouts/templates/TLoginTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ResetPasswordDesktopTablet extends StatelessWidget {
  const ResetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tlogintemplate(
        child: ResetPasswordWidget());
  }
}
