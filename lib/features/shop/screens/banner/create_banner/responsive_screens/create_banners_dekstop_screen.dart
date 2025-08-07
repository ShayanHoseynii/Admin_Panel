import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/features/shop/screens/banner/create_banner/widgets/create_banner_form.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBannersDekstopScreen extends StatelessWidget {
  const CreateBannersDekstopScreen({super.key});

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
                  heading: 'Create Banners', breadcrumbItems: [TRoutes.banners, 'Create Banner']),
             SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              
              CreateBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
