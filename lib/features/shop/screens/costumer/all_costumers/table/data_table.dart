import 'package:admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_panel/features/shop/contollers/costumer/costumer_controller.dart';
import 'package:admin_panel/features/shop/screens/costumer/all_costumers/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());

    return Obx(() {
      
      Text(controller.filteredItems.toString());
      Text(controller.selectedRows.toString());


      return TPaginatedDataTable(
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 700,
          columns: [
            DataColumn2(
                label: const Text('Customer'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Email')),
            const DataColumn2(label: Text('Phone Number')),
            const DataColumn2(label: Text('Registered')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: CustomerRow());
    });
  }
}
