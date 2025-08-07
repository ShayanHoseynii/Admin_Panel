import 'dart:typed_data';
import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/features/media/controllers/media_controller.dart';
import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/features/media/screens/media/widgets/folder_dropdown.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
              children: [
                /// Upload Area
                TRoundedContainer(
                  showBorder: true,
                  height: 250,
                  borderColor: TColors.borderPrimary,
                  backgroundColor: TColors.primaryBackground,
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                          child: Stack(
                        alignment: Alignment.center,
                        children: [
                          DropzoneView(
                            mime: const ['image/jpeg', 'image/png'],
                            cursor: CursorType.Default,
                            operation: DragOperation.copy,
                            onLoaded: () => print('Dropzone loaded'),
                            onError: (ev) => print('Error: $ev'),
                            onLeave: () => print('Left dropzone'),
                            onHover: () => print('Hovering over dropzone'),
                            onCreated: (cntrl) =>
                                controller.dropzoneController = cntrl,
                            onDropFile: (file) async {
                              final bytes = await controller
                                  .dropzoneController
                                  .getFileData(file);
                              final filename = await controller
                                  .dropzoneController.getFilename(file);
                              final mimeType = await controller
                                  .dropzoneController.getFileMIME(file);
                              final image = ImageModel(
                                url: '',
                                folder: '',
                                fileName: filename,
                                contentType: mimeType,
                                localImageToDisplay:
                                    Uint8List.fromList(bytes),
                              );
                              controller.selectedImagesToUpload.add(image);
                              print(
                                  'controller.selectedImagesToUpload.length);${controller.selectedImagesToUpload.length}|${image.fileName}');
                              print('File dropped: ${file.name}');
                            },
                            onDropInvalid: (ev) => print('Invalid drop: $ev'),
                            onDropMultiple: (ev) {
                              print('Multiple files dropped: $ev');
                            },
                          ),

                          ///Dropzone content
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                TImages.defaultMultiImageIcon,
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Text(
                                'Drag and drop images here',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              OutlinedButton(
                                  onPressed: () {
                                    controller.selectLocalImages();
                                  },
                                  child: const Text('Select Images')),
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                if (controller.selectedImagesToUpload.isNotEmpty)

                  /// Locally Selected Media
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Select Folder',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                MediaFolderDropdown(
                                  onChanged: (MediaCategory? newValue) {
                                    if (newValue != null) {
                                      controller.selectedPath.value = newValue;
                                    }
                                  },
                                ),
                              ],
                            ),

                            /// Upload and Remove All Buttons
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      controller.selectedImagesToUpload.clear();
                                    },
                                    child: const Text(
                                      'Remove All',
                                    )),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                TDeviceUtils.isMobileScreen(context)
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              controller
                                                  .uploadImagesConfirmation();
                                            },
                                            child: const Text('Upload')),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Wrap(
                            alignment: WrapAlignment.start,
                            spacing: TSizes.spaceBtwItems / 2,
                            runSpacing: TSizes.spaceBtwItems / 2,
                            children: controller.selectedImagesToUpload
                                .where((image) =>
                                    image.localImageToDisplay != null)
                                .map((element) {
                              return TRoundedImage(
                                imageType: ImageType.memory,
                                width: 90,
                                height: 90,
                                padding: TSizes.sm,
                                memoryImage: element.localImageToDisplay,
                                backgroundColor: TColors.primaryBackground,
                              );
                            }).toList()),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        TDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {controller.uploadImagesConfirmation();},
                                    child: const Text('Upload')))
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
