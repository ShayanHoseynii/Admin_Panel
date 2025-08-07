import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/features/shop/model/brand_model.dart';
import 'package:admin_panel/features/shop/screens/brand/edit_brand/widgets/edit_brand_form.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditBrandDesktopScreen extends StatelessWidget {
  const EditBrandDesktopScreen({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsetsGeometry.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbWithHeading(
                heading: 'Edit Brand',
                breadcrumbItems: [TRoutes.brands, 'Edit Brand'],
                returnToPreviousScreen: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              EditBrandForm(brand: brand),
            ],
          )),
    ));
  }
}
