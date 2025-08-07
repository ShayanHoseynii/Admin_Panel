

import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/features/shop/screens/brand/create_brand/widgets/create_brand_form.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBrandsDesktopScreen extends StatelessWidget {
  const CreateBrandsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SingleChildScrollView(
        child: Padding(padding: EdgeInsetsGeometry.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBreadcrumbWithHeading(heading: 'Create Brand', breadcrumbItems: [TRoutes.brands, 'Create Brand'], returnToPreviousScreen: true,),
            SizedBox(height: TSizes.spaceBtwSections,),
            CreateBrandForm(),
          ],
        )),

      )
    );
  }
}