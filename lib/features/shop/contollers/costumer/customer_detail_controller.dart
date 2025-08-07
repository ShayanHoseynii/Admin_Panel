import 'package:admin_panel/data/repositories/address/address_repository.dart';
import 'package:admin_panel/data/repositories/user/user_repository.dart';
import 'package:admin_panel/features/authentication/models/user_model.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading = true.obs;
  RxBool addressLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

  /// -- Load customer orders
  Future<void> getCustomerOrders() async {
    try {
      ordersLoading.value = true;

      // Fetch customer orders & addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders =
            await UserRepository.instance.fetchUserOrders(customer.value.id!);
      }

      allCustomerOrders.assignAll(customer.value.orders ?? []);

      filteredCustomerOrders.assignAll(customer.value.orders ?? []);

      selectedRows.assignAll(List.generate(
        customer.value.orders != null ? customer.value.orders!.length : 0,
        (index) => false,
      ));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  Future<void> getCustomerAddress() async {
    try {
      addressLoading.value = true;

      // Fetch customer orders & addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses =
            await addressRepository.fetchUserAddresses(customer.value.id!);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      addressLoading.value = false;
    }
  }

  void searchQuery(String query) {
    filteredCustomerOrders.assignAll(allCustomerOrders.where((customer) =>
        customer.id.toLowerCase().contains(query.toLowerCase()) ||
        customer.orderDate.toString().contains(query.toLowerCase())));
    update();
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredCustomerOrders.sort((a, b) {
      if (ascending) {
        return a.id.toLowerCase().compareTo(b.id.toLowerCase());
      } else {
        return b.id.toLowerCase().compareTo(a.id.toLowerCase());
      }
    });

    update();
  }
}
