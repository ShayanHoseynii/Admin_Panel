import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/icons/t_circular_icon.dart';
import 'package:admin_panel/common/widgets/texts/section_heading.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard(
      {super.key,
      required this.title,
      this.icon = Iconsax.arrow_up_3,
      this.color = TColors.success,
      this.onTap,
      required this.subtitle,
      required this.stats,
      required this.headingIcon,
      required this.headingIconColor,
      required this.headingIconBgColor,
      });

  final String title, subtitle;
  final IconData icon;
  final Color color;
  final void Function()? onTap;
  final int stats;
  
  final IconData headingIcon;
  
  final Color headingIconColor;
  
  final Color headingIconBgColor;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(TSizes.lg),
      child: Column(
        children: [
          //Heading
          Row(
            children: [
              TCircularIcon(icon: headingIcon,
              backgroundColor: headingIconBgColor,
              color: headingIconColor,
              size: TSizes.md,),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              TSectionHeading(
                title: title,
                textColor: TColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle, style: Theme.of(context).textTheme.headlineMedium),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(icon, color: color, size: TSizes.iconSm),
                        Text('$stats%',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.apply(
                                    color: color,
                                    overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 135,
                      child: Text('Compared to last month',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.apply(overflow: TextOverflow.ellipsis))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
