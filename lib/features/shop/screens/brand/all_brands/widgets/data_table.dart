import 'package:admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_panel/features/shop/contollers/brand/brand_controller.dart';
import 'package:admin_panel/features/shop/screens/brand/all_brands/widgets/table_source.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Obx(() {
      Text(controller.allItems.length.toString());
      Text(controller.selectedRows.length.toString());

      final lgTable = controller.filteredItems.any((element) =>
          element.brandCategory != null && element.brandCategory!.length > 2);
      return TPaginatedDataTable(
          minWidth: 700,
          tableHeight: lgTable ? 1100 : 760,
          dataRowHeight: lgTable? 1100 : 64,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
                label: const Text('Brand'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? null : 200),
            const DataColumn2(label:  Text('Categories')),
            DataColumn2(
                label: const Text('Featured'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
            DataColumn2(
                label: const Text('Date'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? null : 200),
            DataColumn2(
                label: const Text('Action'),
                fixedWidth:
                    TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
          ],
          source: BrandRows());
    });
  }
}
