import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_panel/features/shop/contollers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatusGraph extends StatelessWidget {
  const OrderStatusGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Status',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Pie Chart
          Obx(
            ()=> controller.orderStatusData.isNotEmpty ? SizedBox(
              height: 400,
              child: PieChart(
                PieChartData(
                  sections: controller.orderStatusData.entries.map((entry) {
                    final status = entry.key;
                    final count = entry.value;
                    return PieChartSectionData(
                      value: count.toDouble(),
                      title: count.toString(),
                      color: THelperFunctions.getOrderStatusColor(status),
                      radius: 100,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    );
                  }).toList(),
                  pieTouchData: PieTouchData(
                    touchCallback: (event, pieTouchResponse) {},
                    enabled: true,
                  ),
                ),
              ),
            ) : const SizedBox(height:400 , child: Row(
              mainAxisAlignment: MainAxisAlignment.center, children: [TLoaderAnimation()],
            ),)
          ),
          // Show Status and Color Meta
          SizedBox(
            width: double.infinity,
            child: Obx(
              ()=> DataTable(
                  columns: const [
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Orders')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows: controller.orderStatusData.entries.map((entry) {
                    final status = entry.key;
                    final count = entry.value;
                    final total = controller.totalAmount[status] ?? 0.0;
                    return DataRow(
                      
                      cells: [
                      DataCell(Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TRoundedContainer(
                            backgroundColor:
                                THelperFunctions.getOrderStatusColor(status),
                            width: 20,
                            height: 20,
                          ),
                          Expanded(
                              child:
                                  Text(' ${status.name.toString().capitalize}'))
                        ],
                      )),
                      DataCell(Text(count.toString())),
                      DataCell(Text('\$${total.toStringAsFixed(2)}')),
                    ]);
                  }).toList()),
            ),
          ),
        ],
      ),
    );
  }
}
