import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/features/media/controllers/media_controller.dart';
import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImagePopup extends StatelessWidget {
  final ImageModel image;
  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
        child: TRoundedContainer(
          width: TDeviceUtils.isDesktopScreen(context)
              ? MediaQuery.of(context).size.width * 0.4
              : double.infinity,
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    TRoundedContainer(
                      backgroundColor: TColors.primaryBackground,
                      child: TRoundedImage(
                        imageType: ImageType.network,
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: TDeviceUtils.isDesktopScreen(context)
                            ? MediaQuery.of(context).size.width * 0.4
                            : double.infinity,
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Iconsax.close_circle)))
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Image Name:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(image.fileName,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text('Image URL',
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      flex: 2,
                      child: Text(image.url,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)),
                  OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(image.url).then((value) =>
                            TLoaders.customToast(message: 'URL copied!'));
                      },
                      child: const Text('Copy URL'))
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                        onPressed: () {
                          MediaController.instance
                              .removeCloudImageConfirmation(image);
                        },
                        child: const Text('Delete Image',
                            style: TextStyle(color: Colors.red))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
