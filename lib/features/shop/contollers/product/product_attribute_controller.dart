import 'package:admin_panel/features/shop/model/product_attribute_model.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/widget/variations_widget.dart';
import 'package:admin_panel/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  final isLoading = false.obs;
  final attributeFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  void addNewAttribute() {
    if (!attributeFormKey.currentState!.validate()) {
      return;
    }

    // Adding Attributes to the list
    productAttributes.add(ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split('|').toList()));

    // Clearing the text Fields after adding
    attributeName.text = '';
    attributes.text = '';
  }

  void removeAttribute(int index, BuildContext ctx) {
    TDialogs.defaultDialog(
        context: ctx,
        onConfirm: () {
          Navigator.of(ctx).pop();
          productAttributes.removeAt(index);
        });
  }

  void resetProductAttributes() {
    productAttributes.clear();
  }
}
