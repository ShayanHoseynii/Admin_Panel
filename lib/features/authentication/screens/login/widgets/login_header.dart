import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
              width: 100,
              height: 100,
              image: AssetImage(TImages.darkAppLogo)),
          const SizedBox(height: TSizes.spaceBtwSections),
          Text(TTexts.loginTitle,
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.sm),
          Text(TTexts.loginSubTitle,
              style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    );
  }
}