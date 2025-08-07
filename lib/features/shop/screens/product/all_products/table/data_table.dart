import 'package:admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:admin_panel/features/shop/contollers/product/product_controller.dart';
import 'package:admin_panel/features/shop/screens/product/all_products/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Obx(() {
      //These two lines are just for redrawing the design on filtered Items change
      // or selected Rows change
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return TPaginatedDataTable(
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 1000,
          columns: [
            DataColumn2(
                label: const Text('Product'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            DataColumn2(
                label: const Text('Stock'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            DataColumn2(
                label: const Text('Sold'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Brand')),
            DataColumn2(
                label: const Text('Price'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: ProductRows());
    });
  }
}
