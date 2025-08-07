import 'package:admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannersRow extends DataTableSource {
  @override
  DataRow? getRow(Object index) {
    return DataRow(cells: [
      const DataCell(
        TRoundedImage(
          width: 180,
          height: 100,
          padding: TSizes.sm,
          image: TImages.banner1,
          borderRadius: TSizes.borderRadiusMd,
          backgroundColor: TColors.primaryBackground,
          imageType: ImageType.asset,
        ),
      ),
      const DataCell(Text('shop')),
      const DataCell(Icon(
        Iconsax.eye,
        color: TColors.primary,
      )),
      DataCell(TTableActionButtons(
        onEditPressed: () => Get.toNamed(TRoutes.editBanner),
        onDeletePressed: () {},
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
