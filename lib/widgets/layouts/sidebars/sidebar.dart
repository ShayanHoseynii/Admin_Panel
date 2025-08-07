import 'package:admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const BeveledRectangleBorder(),
        child: Container(
          decoration: const BoxDecoration(
            color: TColors.white,
            border: Border(right: BorderSide(color: TColors.grey, width: 1)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TCircularImage(
                  width: 100,
                  height: 100,
                  image: TImages.darkAppLogo,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Padding(
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('MENU',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(letterSpacingDelta: 1.2)),

                      // Menu Items
                      const TMenuItem(
                        icon: Iconsax.status,
                        route: TRoutes.dashboard,
                        itemName: 'Dashboard',
                      ),
                      const TMenuItem(
                        icon: Iconsax.image,
                        route: TRoutes.media,
                        itemName: 'Media',
                      ),
                      const TMenuItem(
                        icon: Iconsax.category_2,
                        route: TRoutes.categories,
                        itemName: 'Categories',
                      ),
                      const TMenuItem(
                        icon: Iconsax.dcube,
                        route: TRoutes.brands,
                        itemName: 'Brands',
                      ),
                      const TMenuItem(
                        icon: Iconsax.picture_frame,
                        route: TRoutes.banners,
                        itemName: 'Banners',
                      ),
                      const TMenuItem(
                        icon: Iconsax.shopping_bag,
                        route: TRoutes.products,
                        itemName: 'Products',
                      ),
                      const TMenuItem(
                        icon: Iconsax.profile_2user,
                        route: TRoutes.customers,
                        itemName: 'Customers',
                      ),
                      const TMenuItem(
                        icon: Iconsax.box,
                        route: TRoutes.orders,
                        itemName: 'Orders',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
