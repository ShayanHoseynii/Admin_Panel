import 'package:admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/screens/category/all_categories/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(() {
      //These two lines are just for redrawing the design on filtered Items change
      // or selected Rows change
      Text(controller.filteredItems.toString());
      Text(controller.selectedRows.toString());


      return TPaginatedDataTable(
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 700,
          columns: [
            DataColumn2(
                label: const Text('Category'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Parent Category')),
            const DataColumn2(label: Text('Featured')),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: CategoryRows());
    });
  }
}
