import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/features/shop/contollers/costumer/customer_detail_controller.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomerOrdersRow extends DataTableSource {
  final controller = CustomerDetailController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredCustomerOrders[index];
    final totalAmount = order.items.fold<double>(
        0, (previousValue, element) => previousValue + element.price);
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order),
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
        DataCell(Text('${order.items.length} items')),
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
        DataCell(Text('\$$totalAmount')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredCustomerOrders.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
