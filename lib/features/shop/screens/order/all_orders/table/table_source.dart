import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:admin_panel/features/shop/contollers/order/order_controller.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRows extends DataTableSource {
  final controller = OrderController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];

    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order, parameters: {'orderId' : order.docId}),
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
                  color: TColors.primary,
                ),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
         DataCell(Text('${order.items.length}')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.sm,
              horizontal: TSizes.md,
            ),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status)
                .withOpacity(0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(order.status),
              ),
            ),
          ),
        ),
        DataCell(Text('\$${order.totalAmount}')),
        DataCell(TTableActionButtons(
          view: true,
          edit: false,
          onViewPressed: () =>
              Get.toNamed(TRoutes.orderDetails, arguments: order, parameters: {'orderId' : order.docId}),
          onDeletePressed: () => controller.confirmAndDeleteItem(order),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
