import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/core/utils/helpers/model_helper.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';
import 'package:t_store_admin_panel/data/models/addrees_model.dart';
import 'package:t_store_admin_panel/data/models/user/cart_item_model.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 4)
class OrderModel extends HasId {
  @HiveField(0)
  String? docId;
  @HiveField(1)
  final String? orderId;
  @HiveField(2)
  final String? userId;
  @HiveField(3)
  final OrderStatus? orderStatus;
  @HiveField(4)
  final double? totalAmount;
  @HiveField(5)
  final DateTime? orderDate;
  @HiveField(6)
  final String? paymentMethod;
  @HiveField(7)
  final AddressModel? shippingAddress;
  @HiveField(8)
  final AddressModel? billingAddress;
  @HiveField(9)
  final DateTime? deliveryDate;
  @HiveField(10)
  final List<CartItemModel>? cartItems;
  @HiveField(11)
  final UserModel? userData;

  OrderModel({
    this.docId,
    this.orderId,
    this.userId,
    this.orderStatus,
    this.totalAmount,
    this.orderDate,
    this.paymentMethod,
    this.shippingAddress,
    this.billingAddress,
    this.deliveryDate,
    this.cartItems,
    this.userData,
  });

  OrderModel copyWith({
    String? orderId,
    String? userId,
    OrderStatus? orderStatus,
    double? totalAmount,
    DateTime? orderDate,
    String? paymentMethod,
    AddressModel? shippingAddress,
    AddressModel? billingAddress,
    DateTime? deliveryDate,
    List<CartItemModel>? cartItems,
    UserModel? userData,
  }) => OrderModel(
    orderId: orderId ?? this.orderId,
    userId: userId ?? this.userId,
    orderStatus: orderStatus ?? this.orderStatus,
    totalAmount: totalAmount ?? this.totalAmount,
    orderDate: orderDate ?? this.orderDate,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    shippingAddress: shippingAddress ?? this.shippingAddress,
    billingAddress: billingAddress ?? this.billingAddress,
    deliveryDate: deliveryDate ?? this.deliveryDate,
    cartItems: cartItems ?? this.cartItems,
    userData: userData ?? this.userData,
  );

  String get formattedOrderDate => HelperFunctions.getFormattedDate(orderDate!);

  String get formattedDeliveryDate =>
      HelperFunctions.getFormattedDate(deliveryDate!);

  String get orderStatusText =>
      orderStatus == OrderStatus.delivered
          ? 'Delivered'
          : orderStatus == OrderStatus.shipped
          ? 'Shipped'
          : 'Processing';

  factory OrderModel.fromJson(
    Map<String, dynamic> json,
    String docId,
  ) => OrderModel(
    docId: docId,
    orderId: ModelHelper.containsKeyAndNotEmpty(json, 'id') ? json['id'] : null,
    userId:
        ModelHelper.containsKeyAndNotEmpty(json, 'userId')
            ? json['userId']
            : null,
    orderStatus:
        ModelHelper.containsKeyAndNotEmpty(json, 'status')
            ? HelperFunctions.orderStatusFromString(json['status'])
            : null,
    totalAmount:
        ModelHelper.containsKeyAndNotEmpty(json, 'totalAmount')
            ? json['totalAmount']
            : null,
    orderDate:
        ModelHelper.containsKeyAndNotEmpty(json, 'orderDate')
            ? ModelHelper.parseDate(json['orderDate'])
            : null,
    paymentMethod:
        ModelHelper.containsKeyAndNotEmpty(json, 'paymentMethod')
            ? json['paymentMethod']
            : null,
    shippingAddress:
        ModelHelper.containsKeyAndNotEmpty(json, 'address') // shippingAddress
            ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
            : null,
    billingAddress:
        ModelHelper.containsKeyAndNotEmpty(json, 'address') // billingAddress
            ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
            : null,
    deliveryDate:
        ModelHelper.containsKeyAndNotEmpty(json, 'deliveryDate')
            ? ModelHelper.parseDate(json['deliveryDate'])
            : null,
    cartItems:
        ModelHelper.containsKeyAndNotEmpty(json, 'cartItems')
            ? (json['cartItems'] as List)
                .map((e) => CartItemModel.fromJson(e))
                .toList()
            : null,
  );

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() == null) return OrderModel();
    return OrderModel.fromJson(
      snapshot.data() as Map<String, dynamic>,
      snapshot.id,
    );
  }

  @override
  set id(String? id) {
    docId = id;
  }

  @override
  String get id => docId!;
}
