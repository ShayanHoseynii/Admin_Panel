import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/features/shop/screens/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditBannersDekstopScreen extends StatelessWidget {
  const EditBannersDekstopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbWithHeading(
                heading: 'Edit Banner',
                breadcrumbItems: [TRoutes.banners, 'Edit Banner'],
                returnToPreviousScreen: true,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              EditBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
