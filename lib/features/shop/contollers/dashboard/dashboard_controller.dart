import 'package:admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:admin_panel/features/shop/contollers/costumer/costumer_controller.dart';
import 'package:admin_panel/features/shop/contollers/order/order_controller.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends TBaseController<OrderModel> {
  static DashboardController get instance => Get.find();

  final orderController = Get.put(OrderController());
  final cutomerController = Get.put(CustomerController());

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmount = <OrderStatus, double>{}.obs;

  static final DateTime _staticNow = DateTime.now();

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    print('DashboardController initialized with weekly sales: $weeklySales');
    super.onInit();
  }

  void _calculateOrderStatusData() {
    orderStatusData.clear();
    totalAmount.clear();
    totalAmount.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orderController.allItems) {
      var status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;
      totalAmount[status] = (totalAmount[status] ?? 0.0) + order.totalAmount;
    }
  }

  void _calculateWeeklySales() {
    // Example data for weekly sales
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orderController.allItems) {
      final DateTime orderWeekStart =
          THelperFunctions.getStartOfWeek(order.orderDate);

      //Check if the order date is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;
        index = index < 0 ? index + 7 : index;
        weeklySales[index] += order.totalAmount;

        print(
            'Order Date: ${order.orderDate}, Week Start: $orderWeekStart, Index: $index, Amount: ${order.totalAmount}');
      }
    }
    print('Weekly sales initialized: $weeklySales');
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) => false;

  @override
  Future<void> deleteItem(OrderModel item) async {}

  @override
  Future<List<OrderModel>> fetchItems() async {
    if (orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    if (cutomerController.allItems.isEmpty) {
      await cutomerController.fetchItems();
    }

    _calculateWeeklySales();

    _calculateOrderStatusData();

    return orderController.allItems;
  }
}
