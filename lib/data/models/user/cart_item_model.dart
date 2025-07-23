import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_admin_panel/core/utils/helpers/model_helper.dart';

class CartItemModel {
  final String? productId;
  final String? productName;
  final String? productImage;
  final int quantity;
  final double price;
  final String? brandName;
  final String? variationId;
  final Map<String, dynamic>? selectedVariation;

  CartItemModel({
    this.productId,
    this.productName,
    this.productImage,
    this.quantity = 0,
    this.price = 0.0,
    this.brandName,
    this.variationId,
    this.selectedVariation,
  });

  String get totalAmount => (quantity * price).toStringAsFixed(2);

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId:
          ModelHelper.containsKeyAndNotEmpty(json, 'productId')
              ? json['productId']
              : null,
      productName:
          ModelHelper.containsKeyAndNotEmpty(json, 'title') // productName
              ? json['title']
              : null,
      productImage:
          ModelHelper.containsKeyAndNotEmpty(json, 'imageUrl')
              ? json['imageUrl'] // productImage
              : null,
      quantity: ModelHelper.intOrNull(json, 'quantity') ?? 0,
      price: ModelHelper.doubleOrNull(json, 'price') ?? 0.0,
      brandName:
          ModelHelper.containsKeyAndNotEmpty(json, 'brandName')
              ? json['brandName']
              : null,
      variationId:
          ModelHelper.containsKeyAndNotEmpty(json, 'variationId')
              ? json['variationId']
              : null,
      selectedVariation:
          ModelHelper.containsKeyAndNotEmpty(json, 'selectedVariation')
              ? json['selectedVariation']
              : null,
    );
  }

  factory CartItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() == null) return CartItemModel();

    return CartItemModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
