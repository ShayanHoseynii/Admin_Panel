import 'package:admin_panel/common/widgets/images/image_uploader.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:iconsax/iconsax.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    this.onTapToAddImages,
    this.onTapToRemoveImage,
  });


  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          // Section to Add Additional Product Images
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTapToAddImages,
              child: TRoundedContainer(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        TImages.defaultMultiImageIcon,
                        width: 50,
                        height: 50,
                      ),
                      const Text('Add Additional Product Images'),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Section to Display Added Images
          Expanded(
              child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child:
                      SizedBox(height: 80, child: Obx(() => _uploadImagesOrEmptyList()))),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),

              // Add more Images Button
              TRoundedContainer(
                width: 80,
                height: 80,
                showBorder: true,
                borderColor: TColors.grey,
                backgroundColor: TColors.white,
                onTap: onTapToAddImages,
                child: const Center(
                  child: Icon(Iconsax.add),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

 Widget _uploadImagesOrEmptyList() {
  return additionalProductImagesURLs.isNotEmpty
      ? _uploadImages()
      : emptyList();
}


  ListView _uploadImages() {
    return ListView.separated(
        itemCount: additionalProductImagesURLs.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
        itemBuilder: (context, index) {
          final image = additionalProductImagesURLs[index];
          return TImageUploader(
            top: 0,
            right: 0,
            width: 80,
            height: 80,
            left: null,
            bottom: null,
            icon: Iconsax.trash,
            imageType: ImageType.network,
            image: image,
            onIconButtonPressed: () => onTapToRemoveImage!(index),
          );
        });
  }

 Widget emptyList() {
  return ListView(
    scrollDirection: Axis.horizontal,
    children: const [
       TRoundedContainer(
        backgroundColor: TColors.primaryBackground,
        width: 80,
        height: 80,
        child: Center(child: Text('No Images')),
      ),
    ],
  );
}

}
