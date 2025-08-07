import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_panel/features/shop/contollers/dashboard/dashboard_controller.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class TWeeklySalesGraph extends StatelessWidget {
  const TWeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Sales',
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// Bar Chart
          Obx(
            ()=> controller.weeklySales.isNotEmpty ? SizedBox(
              height: 400,
              child: BarChart(
                BarChartData(
                  titlesData: buildTitlesData(controller.weeklySales),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                    ),
                  ),
                  gridData: const FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    horizontalInterval: 200,
                    drawVerticalLine: false,
                  ),
                  barGroups: controller.weeklySales
                      .asMap()
                      .entries
                      .map((e) => BarChartGroupData(
                            x: e.key,
                            barRods: [
                              BarChartRodData(
                                toY: e.value,
                                color: TColors.primary,
                                width: 30,
                                borderRadius: BorderRadius.circular(TSizes.sm),
                              )
                            ],
                          ))
                      .toList(),
                  groupsSpace: TSizes.spaceBtwItems,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => TColors.secondary,
                    ),
                    touchCallback: TDeviceUtils.isDesktopScreen(context)
                        ? (barTouchEvent, barTouchResponse) {}
                        : null,
                  ),
                ),
              ),
            ) :  const SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [TLoaderAnimation()],),)
          ),
        ],
      ),
    );
  }

  FlTitlesData buildTitlesData(List<double> weeklySales) {
    double maxOrder = weeklySales.reduce((a, b) => a > b ? a : b);
    double stepHeight = (maxOrder / 10).ceilToDouble();
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 38,
          getTitlesWidget: (value, meta) {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final index = value.toInt() % days.length;

            final day = days[index];

            return SideTitleWidget(
              space: 0,
              meta: meta,
              child: Text(day),
            );
          },
        ),
      ),
      leftTitles:  AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        interval: stepHeight <= 0 ? 500 : stepHeight,
        reservedSize: 50,
      )),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }
}
