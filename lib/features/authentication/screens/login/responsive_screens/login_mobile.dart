import 'package:admin_panel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:admin_panel/features/authentication/screens/login/widgets/login_header.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(child: Padding(padding: EdgeInsetsGeometry.all(TSizes.defaultSpace),
      child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace), child: Column(
        children: [
          LoginHeader(),
          LoginForm(),
        ],
      ),),),),
      
    );
  }
}