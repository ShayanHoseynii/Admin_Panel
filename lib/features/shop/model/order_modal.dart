import 'package:admin_panel/features/shop/model/address_model.dart';
import 'package:admin_panel/features/shop/model/cart_item_model.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String docId;
  OrderStatus status;
  final double shippingCost;
  final double taxCost;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String paymentMethod;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.shippingAddress,
    this.billingAddress,
    this.deliveryDate,
    this.billingAddressSameAsShipping = true,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : 'Not Delivered';
  String get orderStatusText => status == OrderStatus.delivered
      ? 'Deliverd'
      : status == OrderStatus.shipped
          ? 'shipment on the way'
          : 'Processing';

  static OrderModel empty() {
    return OrderModel(
      id: '',
      items: [],
      status: OrderStatus.pending,
      totalAmount: 0.0,
      shippingCost: 0,
      taxCost: 0,
      orderDate: DateTime.now(),
    );
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;

      return OrderModel(
      docId: snapshot.id,
      id: data.containsKey('id') ? data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status')
    ? OrderStatus.values.firstWhere(
        (e) => e.name == (data['status'] as String).replaceAll('OrderStatus.', ''),
        orElse: () => OrderStatus.pending,
      )
    : OrderStatus.pending,
      totalAmount: data.containsKey('totalAmount')
          ? (data['totalAmount'] as num).toDouble()
          : 0.0,
      shippingCost: data.containsKey('shippingCost')
          ? (data['shippingCost'] as num).toDouble()
          : 0.0,
      taxCost: data.containsKey('taxCost')
          ? (data['taxCost'] as num).toDouble()
          : 0.0,
      orderDate: data.containsKey('orderDate')
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data.containsKey('paymentMethod')
          ? data['paymentMethod'] as String
          : '',
      billingAddressSameAsShipping:
          data.containsKey('billingAddressSameAsShipping')
              ? data['billingAddressSameAsShipping'] as bool
              : true,
      billingAddress: data.containsKey('billingAddress') && data['billingAddress'] != null
          ? AddressModel.fromMap(data['billingAddress'] as Map<String, dynamic>)
          : null,
      shippingAddress: data.containsKey('shippingAddress') && data['shippingAddress'] != null
          ? AddressModel.fromMap(
              data['shippingAddress'] as Map<String, dynamic>)
          : null,
      deliveryDate:
          data.containsKey('deliveryDate') && data['deliveryDate'] != null
              ? (data['deliveryDate'] as Timestamp).toDate()
              : null,
      items: data['items'] != null
          ? List<CartItemModel>.from(
              (data['items'] as List)
                  .where((item) => item != null)
                  .map((item) {
                if (item is Map<String, dynamic>) {
                  return CartItemModel.fromJson(item);
                } else {
                  // Handle case where item might be a CartItemModel already
                  return CartItemModel.empty();
                }
              }),
            )
          : [],
      );
         } catch (e) {
       print('Error parsing order ${snapshot.id}: $e');
       print('Order data: ${snapshot.data()}');
       // Return empty order instead of rethrowing to prevent app crash
       return OrderModel.empty();
     }
  }

 Map<String, dynamic> toJson() {
  return {
    'id': id,
    'userId': userId,
    'docId': docId,
    'status': status.name,
    'totalAmount': totalAmount,
    'shippingCost': shippingCost,
    'taxCost': taxCost,
    'orderDate': Timestamp.fromDate(orderDate),
    'deliveryDate': deliveryDate != null ? Timestamp.fromDate(deliveryDate!) : null,
    'paymentMethod': paymentMethod,
    'billingAddressSameAsShipping': billingAddressSameAsShipping,
    'shippingAddress': shippingAddress?.toJson(),
    'billingAddress': billingAddress?.toJson(),
    'items': items.map((item) => item.toJson()).toList(),
  };
}

}
