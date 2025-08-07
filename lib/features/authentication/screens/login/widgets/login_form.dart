import 'package:admin_panel/features/authentication/controllers/login_controller.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              validator: TValidator.validateEmail,
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    TValidator.validateEmptyText("Password", value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye))),
              ),
            ),

            /// remember me and forget pass
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            Row(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) =>
                          controller.rememberMe.value = value!)),
                  const Text(TTexts.rememberMe)
                ],
              ),
              TextButton(
                  onPressed: () => Get.toNamed(TRoutes.forgetPassword),
                  child: const Text(TTexts.forgetPassword))
            ]),

            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// sign in but
            SizedBox(
              width: double.infinity,
              //child:  ElevatedButton(
              //     onPressed: () => controller.emailAndPasswordSignIn(),
              //     child: const Text(TTexts.signIn)),
              child: ElevatedButton(
                  onPressed: () => controller.emailAndPasswordSignIn(),
                  child: const Text(TTexts.signIn)),
            )
          ],
        ),
      ),
    );
  }
}
