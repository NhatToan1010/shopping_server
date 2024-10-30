import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_server/features/personalization/models/address_model.dart';
import 'package:shopping_server/utils/constants/enums.dart';
import 'package:shopping_server/utils/formatters/formatter.dart';

import 'cart_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String paymentMethod;
  final double totalAmount;
  final OrderStatus orderStatus;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final AddressModel? deliveryAddress;
  final List<CartModel> itemsPurchase;

  OrderModel({
    required this.id,
    this.userId = '',
    this.paymentMethod = 'PayPal',
    required this.totalAmount,
    required this.orderStatus,
    required this.orderDate,
    this.deliveryDate,
    this.deliveryAddress,
    required this.itemsPurchase,
  });

  static OrderModel empty() {
    return OrderModel(
      id: '',
      totalAmount: 0.0,
      orderStatus: OrderStatus.processing,
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      deliveryAddress: AddressModel.empty(),
      itemsPurchase: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "UserId": userId,
      "PaymentMethod": paymentMethod,
      "TotalAmount": totalAmount,
      "OrderStatus": orderStatus.toString(),
      "OrderDate": orderDate,
      "DeliveryDate": deliveryDate,
      "DeliveryAddress": deliveryAddress?.toJson(),
      "ItemsPurchase": itemsPurchase.map((item) => item.toJson()).toList(),
    };
  }

  String get formattedOrderDate => Formatter.formatDate(orderDate);

  String get formattedDeliveryDate =>
      deliveryDate != null ? Formatter.formatDate(deliveryDate) : 'Calculating...';

  String get orderStatusText => orderStatus == OrderStatus.delivered
      ? 'Delivered'
      : orderStatus == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  factory OrderModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data()!.isNotEmpty) {
      final data = document.data()!;

      return OrderModel(
        id: data["Id"] as String,
        userId: data["UserId"] as String,
        paymentMethod: data["PaymentMethod"] as String,
        totalAmount: data["TotalAmount"] as double,
        orderStatus: OrderStatus.values.firstWhere((e) => e.toString() == data["OrderStatus"]),
        orderDate: (data["OrderDate"] as Timestamp).toDate(),
        deliveryAddress: AddressModel.fromMap(data["DeliveryAddress"] as Map<String, dynamic>),
        deliveryDate: data["DeliveryDate"] != null
            ? (data["DeliveryDate"] as Timestamp).toDate()
            : null,
        itemsPurchase: data["ItemsPurchase"]
            .map<CartModel>((item) => CartModel.fromJson(item as Map<String, dynamic>))
            .toList() as List<CartModel>,
      );
    }
    return empty();
  }
}
