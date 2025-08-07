import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    return Column(
          children: [
    IconButton(onPressed: ()=> Get.offAllNamed(TRoutes.login), icon: const Icon(CupertinoIcons.clear)),
    const SizedBox(height: TSizes.spaceBtwItems,),
    
    const Image(image: AssetImage(TImages.deliveredEmailIllustration), width: 300, height: 300),
    const SizedBox(height: TSizes.spaceBtwItems,),
    
     Text(TTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
     const SizedBox(height: TSizes.spaceBtwItems,),
     Text(email, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge,),
    const SizedBox(height: TSizes.spaceBtwItems,),
    Text(TTexts.changeYourPasswordSubTitle,
    textAlign: TextAlign.center,
    style: Theme.of(context).textTheme.labelMedium,),
    const SizedBox(height: TSizes.spaceBtwSections,),
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: () =>Get.offAllNamed(TRoutes.login), child: const Text('Done')),
    ),
    const SizedBox(height: TSizes.spaceBtwItems,),
    SizedBox(
      width: double.infinity,
      child: TextButton(onPressed: (){}, child: const Text(TTexts.resendEmail)),
    )
          ],
        );
  }
}
