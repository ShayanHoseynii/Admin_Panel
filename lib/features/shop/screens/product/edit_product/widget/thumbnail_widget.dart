import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/features/shop/contollers/product/product_image_controller.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductThumbnailWidget extends StatelessWidget {
  const ProductThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductImageController controller = Get.put(ProductImageController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Thumbnail',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TRoundedContainer(
            backgroundColor: TColors.primaryBackground,
            height: 300,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Obx(
                        () => TRoundedImage(
                          width: 200,
                          height: 200,
                          imageType:
                              controller.selectedThumbnailImageUrls.value ==
                                      null
                                  ? ImageType.asset
                                  : ImageType.network,
                          image: controller.selectedThumbnailImageUrls.value ??
                              TImages.defaultSingleImageIcon,
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                        onPressed: () => controller.selectThumnailImage(),
                        child: const Text('Add Thumbnail')),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
