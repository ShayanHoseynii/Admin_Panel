import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:admin_panel/features/shop/contollers/order/order_controller.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/device/device_utility.dart';
import 'package:admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          Row(
            children: [
              // Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(
                      order.formattedOrderDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),

              // Items
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    Text(
                      '${order.items.length} Items',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),

              // Status
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    Obx(() {
                      if (controller.statusLoader.value) {
                        return const TShimmerEffect(
                            width: double.infinity, height: 55);
                      }
                      
                      return TRoundedContainer(
                        radius: TSizes.cardRadiusSm,
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm,
                          vertical: 0,
                        ),
                        backgroundColor:
                            THelperFunctions.getOrderStatusColor(order.status)
                                .withOpacity(0.1),
                        child: DropdownButton<OrderStatus>(
                          value: order.status,
                          items: OrderStatus.values
                              .map(
                                (status) => DropdownMenuItem<OrderStatus>(
                                  value: status,
                                  child: Text(
                                    status.name.capitalize.toString(),
                                    style: TextStyle(
                                        color: THelperFunctions
                                            .getOrderStatusColor(
                                                OrderStatus.pending)),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (OrderStatus? newValue) {
                            if (newValue != null) {
                              controller.updateOrderStatus(order, newValue);
                            }
                          },
                          underline: const SizedBox.shrink(),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total'),
                  Text(
                    '\$${order.totalAmount}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
