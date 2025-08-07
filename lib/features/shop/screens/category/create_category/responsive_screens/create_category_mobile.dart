import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/features/shop/screens/category/create_category/widgets/create_category_form.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateCategoryMobile extends StatelessWidget {
  const CreateCategoryMobile({super.key});

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
                heading: 'Create Category',
                breadcrumbItems: [TRoutes.categories, 'Create Category'],
                returnToPreviousScreen: true,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              CreateCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
