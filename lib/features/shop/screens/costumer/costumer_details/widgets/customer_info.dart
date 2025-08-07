import 'package:admin_panel/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/features/authentication/models/user_model.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});
  final UserModel customer;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Information',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Row(
            children: [
               TRoundedImage(
                imageType:customer.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                padding: 0,
                backgroundColor: TColors.primaryBackground,
                image: customer.profilePicture.isNotEmpty ? customer.profilePicture :  TImages.user,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.fullName,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                   Text(
                    customer.email,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('User Name'),
              ),
              const Text(':'),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(customer.userName,
                      style: Theme.of(context).textTheme.titleLarge)),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              const SizedBox(
                width: 120,
                child: Text('Country'),
              ),
              const Text(':'),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text("Turkey",
                      style: Theme.of(context).textTheme.titleLarge)),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(children: [
            const SizedBox(
              width: 120,
              child: Text('Phone Number'),
            ),
            const Text(':'),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Expanded(
                child:
                    Text(customer.phoneNumber, style: Theme.of(context).textTheme.titleLarge)),
          ]),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          const Divider(),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Last Order',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('7 days ago'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Average Order Value',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('\$333'),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Regirstered',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(customer.formattedDate),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Marketing',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('Subscribed'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
