import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/errors/firebase_error.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_category_model.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

abstract class BrandFirebaseServices {
  Future<Either<String, List<BrandModel>>> fetchBrands();
  Future<Either<String, String>> createBrand(BrandModel brand);
  Future<Either<String, BrandModel>> updateBrand(BrandModel brand);
  Future<Either<String, Unit>> deleteBrand(BrandModel brand);
}

class BrandFirebaseServicesImpl implements BrandFirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseErrorHandler _errorHandler = FirebaseErrorHandler();
  final brandCollection = FirebaseCollections.brands;
  final brandCategoryCollection = FirebaseCollections.brandCategories;
  final categoryCollection = FirebaseCollections.categories;

  DocumentReference _brandDocRef(String? id) =>
      _firestore.collection(brandCollection).doc(id);

  CollectionReference get _brandCategoryRef =>
      _firestore.collection(brandCategoryCollection);

  CollectionReference get _categoryRef =>
      _firestore.collection(categoryCollection);

  @override
  Future<Either<String, String>> createBrand(BrandModel brand) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final batch = _firestore.batch();
      final brandDocRef = _firestore.collection(brandCollection).doc();
      final brandId = brandDocRef.id;

      final brandWithId = brand.copyWith(id: brandId);
      batch.set(brandDocRef, brandWithId.toJson());

      final categories = brand.brandCategories ?? [];

      for (final category in categories) {
        final brandCategory = BrandCategoryModel(
          brandId: brandId,
          categoryId: category.id!,
        );
        final docRef = _brandCategoryRef.doc();
        batch.set(docRef, brandCategory.toJson());
      }

      await batch.commit();
      return brandId;
    });
  }

  @override
  Future<Either<String, List<BrandModel>>> fetchBrands() async {
    return await _errorHandler.handleErrorEitherAsync(() async {
      final brandSnapshot = await _firestore.collection(brandCollection).get();
      final List<BrandModel> brands = [];

      for (final brandDoc in brandSnapshot.docs) {
        final brandId = brandDoc.id;
        final brandData = brandDoc.data();

        final brandCategoriesSnapshot =
            await _brandCategoryRef.where('brandId', isEqualTo: brandId).get();

        final categoryIds =
            brandCategoriesSnapshot.docs
                .map((doc) => doc['categoryId'] as String)
                .toList();

        final categoryFutures = categoryIds.map(
          (id) => _categoryRef.doc(id).get(),
        );
        final categoryDocs = await Future.wait(categoryFutures);

        final categoryModels =
            categoryDocs
                .where((doc) => doc.exists)
                .map(
                  (doc) => CategoryModel.fromJson(
                    doc as DocumentSnapshot<Map<String, dynamic>>,
                  ),
                )
                .toList();

        final brandModel = BrandModel.fromMap(
          brandData,
        ).copyWith(id: brandId, brandCategories: categoryModels);

        brands.add(brandModel);
      }

      return brands;
    });
  }

  @override
  Future<Either<String, BrandModel>> updateBrand(BrandModel brand) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final batch = _firestore.batch();
      final brandDocRef = _brandDocRef(brand.id);

      // Update brand info
      batch.update(brandDocRef, brand.toJson());

      final brandCategoriesSnapshot =
          await _brandCategoryRef.where('brandId', isEqualTo: brand.id).get();

      final existingMap = {
        for (final doc in brandCategoriesSnapshot.docs)
          doc['categoryId'] as String: doc.reference,
      };

      final newCategoryIds =
          brand.brandCategories
              ?.map((c) => c.id)
              .whereType<String>()
              .toList() ??
          [];

      final categoriesToDelete =
          existingMap.keys.where((id) => !newCategoryIds.contains(id)).toList();

      final categoriesToAdd =
          newCategoryIds.where((id) => !existingMap.containsKey(id)).toList();

      // Delete removed
      for (final id in categoriesToDelete) {
        final ref = existingMap[id];
        if (ref != null) batch.delete(ref);
      }

      // Add new
      for (final id in categoriesToAdd) {
        final brandCategory = BrandCategoryModel(
          brandId: brand.id!,
          categoryId: id,
        );
        final docRef = _brandCategoryRef.doc();
        batch.set(docRef, brandCategory.toJson());
      }

      await batch.commit();
      return brand;
    });
  }

  @override
  Future<Either<String, Unit>> deleteBrand(BrandModel brand) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final batch = _firestore.batch();
      final brandDocRef = _brandDocRef(brand.id);

      batch.delete(brandDocRef);

      final brandCategoriesSnapshot =
          await _brandCategoryRef.where('brandId', isEqualTo: brand.id).get();

      for (final doc in brandCategoriesSnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      return unit;
    });
  }
}
