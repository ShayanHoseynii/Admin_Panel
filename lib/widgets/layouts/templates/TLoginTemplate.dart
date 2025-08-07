import 'package:admin_panel/common/styles/spacing_styles.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class Tlogintemplate extends StatelessWidget {
  const Tlogintemplate({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 550,
      child: SingleChildScrollView(
        child: Container(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
                color: TColors.white,
                borderRadius: BorderRadius.circular(TSizes.cardRadiusLg)),
            child: child),
      ),
    ));
  }
}
