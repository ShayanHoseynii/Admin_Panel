import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/features/shop/contollers/order/order_detail_controller.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    
    // Call getCustomerOfCurrentOrder only once when widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCustomerOfCurrentOrder(order.userId);
    });
    
    return Obx(() {
      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Row(
                children: [
                   TRoundedImage(
                    padding: 0,
                    backgroundColor: TColors.primaryBackground,
                    image: controller.customer.value.profilePicture.isNotEmpty ? controller.customer.value.profilePicture : TImages.user,
                    imageType:controller.customer.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.customer.value.fullName.isNotEmpty 
                              ? controller.customer.value.fullName 
                              : 'Unknown Customer',
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                         Text(
                          controller.customer.value.email.isNotEmpty 
                              ? controller.customer.value.email 
                              : 'No email available',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        SizedBox(
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Person',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  controller.customer.value.fullName.isNotEmpty 
                      ? controller.customer.value.fullName 
                      : 'Unknown Customer',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Text(
                  controller.customer.value.email.isNotEmpty 
                      ? controller.customer.value.email 
                      : 'No email available',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Text(
                  controller.customer.value.phoneNumber.isNotEmpty 
                      ? controller.customer.value.formattedPhoneNo 
                      : 'No phone number available',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const SizedBox(
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Contact info
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Adress',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  order.shippingAddress != null ? order.shippingAddress!.name : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Text(
                  order.shippingAddress != null ? order.shippingAddress!.toString() : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Billing Address
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Adress',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  order.billingAddressSameAsShipping 
                      ? (order.shippingAddress?.name ?? 'No shipping address')
                      : (order.billingAddress?.name ?? 'No billing address'),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                Text(
                  order.billingAddressSameAsShipping 
                      ? (order.shippingAddress?.toString() ?? 'No shipping address')
                      : (order.billingAddress?.toString() ?? 'No billing address'),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
    });
  }
}
