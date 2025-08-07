import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_panel/data/repositories/address/address_repository.dart';
import 'package:admin_panel/features/shop/contollers/costumer/costumer_controller.dart';
import 'package:admin_panel/features/shop/model/address_model.dart';
import 'package:admin_panel/common/widgets/data_table/table_header.dart';
import 'package:admin_panel/features/shop/screens/costumer/all_costumers/table/data_table.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    final repo = Get.put(AddressRepository());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbWithHeading(
                  heading: 'Customers', breadcrumbItems: ['Customers']),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TRoundedContainer(
                child: Column(
                  children: [
                    TTableHeader(
                      searchOnChanged: (query) => controller.searchQuery(query),
                      searchController: controller.searchTextController,
                      showLeftWidget: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return const TLoaderAnimation();
                        }
                        return const CustomerTable();
                      },
                    )
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
