import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm),
            Text(
              'Create New Banner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // Image Uploader & Featured Checkbox
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: const TRoundedImage(
                    imageType: ImageType.asset,
                    width: 400,
                    height: 200,
                    backgroundColor: TColors.primaryBackground,
                    image: TImages.defaultImage,
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                Text('Make your Banner Active or InActibve',
                    style: Theme.of(context).textTheme.bodyMedium),
                CheckboxMenuButton(
                    value: true,
                    onChanged: (value) {},
                    child: const Text('Active')),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                DropdownButton<String>(
                  value: 'Search',
                  onChanged: (String? newValue) {},
                  items: const [
                    DropdownMenuItem<String>(
                        value: 'Home', child: Text('Home')),
                    DropdownMenuItem<String>(
                      value: 'Search',
                      child: Text('Search'),
                    )
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields * 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Create')),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields * 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
