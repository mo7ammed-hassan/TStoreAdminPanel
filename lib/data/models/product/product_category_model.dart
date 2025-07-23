import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String productId;
  final String categoryId;

  ProductCategoryModel(this.productId, this.categoryId);

  // fromJson
  factory ProductCategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductCategoryModel(data['productId'], data['categoryId']);
    } else {
      return ProductCategoryModel('', '');
    }
  }
}
