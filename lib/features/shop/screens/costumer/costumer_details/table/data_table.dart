import 'package:admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/contollers/costumer/customer_detail_controller.dart';
import 'package:admin_panel/features/shop/screens/costumer/costumer_details/table/table_source.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;

    return Obx(() {
      Text(controller.filteredCustomerOrders.toString());
      Text(controller.selectedRows.toString());

      return TPaginatedDataTable(
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 550,
          tableHeight: 640,
          dataRowHeight: kMinInteractiveDimension,
          columns: [
            DataColumn2(
                label: const Text('Order Id'),
                onSort: (columnIndex, ascending) =>
                    controller.sortById(columnIndex, ascending)),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Items')),
            DataColumn2(
                label: const Text('Status'),
                fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null),
            const DataColumn2(label: Text('Amount'), numeric: true),
          ],
          source: CustomerOrdersRow());
    });
  }
}
