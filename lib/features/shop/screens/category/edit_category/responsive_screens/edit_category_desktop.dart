import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:admin_panel/features/shop/screens/category/edit_category/widgets/edit_category_form.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditCategoryDesktop extends StatelessWidget {
  const EditCategoryDesktop({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbWithHeading(
                heading: 'Update Category',
                breadcrumbItems: [TRoutes.categories, 'Update Category'],
                returnToPreviousScreen: true,
              ),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              EditCategoryForm(category: category),
            ],
          ),
        ),
      ),
    );
  }
}
