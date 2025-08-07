import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/screens/category/all_categories/table/data_table.dart';
import 'package:admin_panel/common/widgets/data_table/table_header.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesDesktopScreen extends StatelessWidget {
  const CategoriesDesktopScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbWithHeading(
                  heading: 'Categories', breadcrumbItems: ['Categories']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TRoundedContainer(
                child: Column(
                  children: [
                    TTableHeader(
                      searchOnChanged: (query) => controller.searchQuery(query),
                      searchController: controller.searchTextController,
                      buttonText: 'Create New Category',
                      onPressed: () => Get.toNamed(TRoutes.createCategory),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Obx((){
                      if(controller.isLoading.value) return const TLoaderAnimation();
                      return const CategoryTable();},)

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
