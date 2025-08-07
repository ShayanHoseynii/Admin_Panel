import 'package:admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:admin_panel/data/repositories/orders/order_repository.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class OrderController extends TBaseController<OrderModel> {
  static OrderController get instance => Get.find();
  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;

  final _orderRepository = Get.put(OrderRepository());

  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false;
    return await _orderRepository.getAllOrders();
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (OrderModel o) => o.id.toLowerCase(),
    );
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (OrderModel o) => o.orderDate.toString().toLowerCase(),
    );
  }

  Future<void> updateOrderStatus(
      OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(
          order.docId, {'status': newStatus.toString()});
      updateItemFromLists(order);
      orderStatus.value = newStatus;
      TLoaders.successSnackBar(
          title: 'Updated', message: 'Order Status Update');
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}
