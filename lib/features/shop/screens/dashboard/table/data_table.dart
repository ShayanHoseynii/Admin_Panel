import 'package:admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_panel/features/shop/contollers/order/order_controller.dart';
import 'package:admin_panel/features/shop/screens/dashboard/table/table_source.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return TPaginatedDataTable(
                  sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 700,
          tableHeight: 500,
          dataRowHeight: TSizes.xl * 1.2,
          columns:  [
            DataColumn2(label: const Text('Order ID'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
            DataColumn2(label: const  Text('Date'), onSort: (columnIndex, ascending) => controller.sortByDate(columnIndex, ascending),),
            const DataColumn2(label: Text('Items')),
            const DataColumn2(label: Text('Status')),
            const DataColumn2(label: Text('Amount')),
          ],
          source: DashboardOrderRows());
    });
  }
}
