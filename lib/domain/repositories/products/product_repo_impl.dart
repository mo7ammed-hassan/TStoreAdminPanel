import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/errors/firebase_error.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_category_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/data/services/abstract/generic_firebase_services.dart';

class ProductRepoImpl extends GenericRepository<ProductModel> {
  final GenericFirebaseServices<ProductModel> genericFirebaseServices;
  final FirebaseErrorHandler _errorHandler = FirebaseErrorHandler();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProductRepoImpl(this.genericFirebaseServices);

  DocumentReference _productDocRef(String? id) =>
      _firestore.collection(FirebaseCollections.products).doc(id);

  CollectionReference get _productCategoryRef =>
      _firestore.collection(FirebaseCollections.productCategories);

  CollectionReference get _productRef =>
      _firestore.collection(FirebaseCollections.products);

  @override
  Future<Either<String, String>> createItem(ProductModel item) async {
    return await genericFirebaseServices.createItem(item);
  }

  @override
  Future<Either<String, Unit>> deleteItem(ProductModel item) async {
    return await genericFirebaseServices.deleteItem(item);
  }

  @override
  Future<Either<String, List<ProductModel>>> fetchItems() async {
    return await genericFirebaseServices.fetchItems();
  }

  @override
  Future<Either<String, ProductModel>> updateItem(ProductModel item) async {
    return await genericFirebaseServices.updateItem(item);
  }

  Future<Either<String, String>> createProductCategory(
    ProductModel item,
    List<CategoryModel> categories,
  ) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final batch = FirebaseFirestore.instance.batch();

      final productDocRef = _productRef.doc();
      item = item.copyWith(id: productDocRef.id);

      // first create the product
      batch.set(productDocRef, item.toJson());

      // then create the product category
      for (var category in categories) {
        final DocumentReference docRef = _productCategoryRef.doc();
        batch.set(docRef, {'productId': item.id, 'categoryId': category.id});
      }
      await batch.commit();

      return productDocRef.id;
    });
  }

  Future<Either<String, Unit>> deleteProductCategory(String productId) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final batch = FirebaseFirestore.instance.batch();

      final productRef = _productDocRef(productId);

      batch.delete(productRef);

      // then delete the product category
      final querySnapshot =
          await _productCategoryRef
              .where('productId', isEqualTo: productId)
              //.where('categoryId', isEqualTo: item.categoryId)
              .get();

      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      return unit;
    });
  }

  Future<Either<String, List<ProductCategoryModel>>> getProductCategories(
    String productId,
  ) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final snapshot =
          await _productCategoryRef
              .where('productId', isEqualTo: productId)
              .get();

      return snapshot.docs
          .map(
            (querySnapShot) => ProductCategoryModel.fromSnapshot(
              querySnapShot as DocumentSnapshot<Map<String, dynamic>>,
            ),
          )
          .toList();
    });
  }

  Future<Either<String, Unit>> updateProductCategory(
    ProductModel item,
    List<CategoryModel> categories,
  ) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final batch = FirebaseFirestore.instance.batch();

      final productDocRef = _productDocRef(item.id);

      // first update the product
      batch.update(productDocRef, item.toJson());

      // then update the product category
      final querySnapshot =
          await _productCategoryRef
              .where('productId', isEqualTo: item.id)
              .get();

      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      for (var category in categories) {
        final DocumentReference docRef = _productCategoryRef.doc();
        batch.set(docRef, {'productId': item.id, 'categoryId': category.id});
      }
      await batch.commit();

      return unit;
    });
  }
}
