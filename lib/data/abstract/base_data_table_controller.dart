import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/popups/full_screen_loader.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class TBaseController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  // Method to be implemented by sublasses for fetching item.
  Future<List<T>> fetchItems();

  // Method to be implemented by sublasses for deleting on item.
  Future<void> deleteItem(T item);

  // Method to be implemented by sublasses for checking if an item contains the search query.
  bool containsSearchQuery(T item, String query);

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (index) => false));
    } catch (e) {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void sortByProperty(int columnIndex, bool ascending, Function(T) property) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where((item) => containsSearchQuery(item, query)),
    );
  }

  void confirmAndDeleteItem(T item) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: () async => await deleteOnConfirm(item),
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: TSizes.buttonHeight / 2,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadiusGeometry.circular(TSizes.buttonRadius * 5))),
          child: const Text('Ok'),
        ),
      ),
      cancel: SizedBox(
        child: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: TSizes.buttonHeight / 2,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadiusGeometry.circular(TSizes.buttonRadius * 5))),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  deleteOnConfirm(T item) async {
    try {
      // Removing the confirmation Dialog
      TFullScreenLoader.stopLoading();

      // Start the loader
      TFullScreenLoader.popUpCircular();

      await deleteItem(item);

      removeItemFromLists(item);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Item Deleted', message: 'Your Item has been Deleted.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));

    filteredItems.refresh(); // Refresh the UI to reflect the changes
  }

  void updateItemFromLists(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[filteredItemIndex] = item;

    filteredItems.refresh();
  }
}
