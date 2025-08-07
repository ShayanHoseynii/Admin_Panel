import 'package:admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_panel/features/shop/contollers/order/order_controller.dart';
import 'package:admin_panel/features/shop/screens/order/all_orders/table/table_source.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      return TPaginatedDataTable(
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 700,
          columns: [
             DataColumn2(
              onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending),
              label: const Text('Order Id'),
            ),
             DataColumn2(label: Text('Date'), onSort: (columnIndex, ascending) => controller.sortByDate(columnIndex, ascending),),
            const DataColumn2(label: Text('Items')),
            DataColumn2(
                label: const Text('Status'),
                fixedWidth: TDeviceUtils.isMobileScreen(context) ? 120 : null),
            const DataColumn2(label: Text('Amount'), numeric: true),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: OrderRows());
    });
  }
}
