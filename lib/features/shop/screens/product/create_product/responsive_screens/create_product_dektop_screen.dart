import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/features/shop/contollers/product/create_product_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_image_controller.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/additional_images.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/attributes_widget.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/bottom_navigation_widget.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/brand_widget.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/product_categories_widget.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/product_type_widget.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/stock_pricing_widget.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/thumbnail_widget.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/title_description.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/variations_widget.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductDektopScreen extends StatelessWidget {
  const CreateProductDektopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImageController());
    final createProductController = Get.put(CreateProductController());
    final productController = Get.put(ProductController());

    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Create Product',
                  breadcrumbItems: [TRoutes.products, 'Create Product']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProductTitleAndDescription(),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Text(
                                'Stock & Pricing',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),

                              // Single or Variable type
                              const ProductTypeWidget(),
                              const SizedBox(
                                height: TSizes.spaceBtwInputFields,
                              ),
                              
                              // Stock and Pricing
                              const ProductStockPricingWidget(),
                              const SizedBox(
                                height: TSizes.spaceBtwInputFields,
                              ),

                              // Attributes
                              const ProductAttributes(),
                              const SizedBox(
                                height: TSizes.spaceBtwSections,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        // Variations
                        const ProductVariation(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.defaultSpace,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      // Product Thumbnail
                      const ProductThumbnailWidget(),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Add Images Widget
                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Product Images',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            ProductAdditionalImages(
                              additionalProductImagesURLs:
                                  controller.additionalProductImagesUrls,
                              onTapToAddImages: () =>
                                  controller.selectMultipleProductImages(),
                              onTapToRemoveImage: (index) =>
                                  controller.removeImage(index),
                            ),

                            // Select Brands

                            const ProductBrand(),
                            const SizedBox(height: TSizes.spaceBtwSections),

                            // Select Categories
                            const ProductCategoriesWidget(),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
