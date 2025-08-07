import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_panel/features/shop/contollers/product/product_controller.dart';
import 'package:admin_panel/common/widgets/data_table/table_header.dart';
import 'package:admin_panel/features/shop/screens/product/all_products/table/data_table.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDektopScreen extends StatelessWidget {
  const ProductDektopScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbWithHeading(
                  heading: 'Products', breadcrumbItems: ['Products']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Obx(() {
                if (controller.isLoading.value) return const TLoaderAnimation();
                return TRoundedContainer(
                  child: Column(
                    children: [
                      TTableHeader(
                        searchOnChanged: (query) =>
                            controller.searchQuery(query),
                        searchController: controller.searchTextController,
                        buttonText: 'Add Product',
                        onPressed: () => Get.toNamed(TRoutes.createProduct),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      // Table
                      const ProductTable(),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
