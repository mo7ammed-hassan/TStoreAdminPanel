import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_attributes_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_variation_model.dart';

class CreateProductStates {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final ProductModel? product;
  final String? thumbnail;
  final List<String>? additionalImages;
  final List<CategoryModel>? categories;
  final BrandModel? brand;
  final ProductType productType;
  final bool isFeatured;
  final bool isCreatedLoading;
  final List<String>? productCategories;
  final List<ProductVariationModel>? productVariations;
  final List<ProductAttributesModel>? productAttributes;
  final List<BrandModel>? brands;
  final bool isEditingLoading;

  const CreateProductStates({
    this.productCategories,
    this.productVariations,
    this.productAttributes,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.product,
    this.thumbnail,
    this.additionalImages,
    this.categories,
    this.brand,
    this.productType = ProductType.single,
    this.isFeatured = true,
    this.brands,
    this.isCreatedLoading = false,
    this.isEditingLoading = false,
  });

  CreateProductStates copyWith({
    bool? isLoading = false,
    String? errorMessage = '',
    String? successMessage = '',
    ProductModel? product,
    String? thumbnail,
    List<String>? additionalImages,
    List<String>? productCategories,
    List<ProductVariationModel>? productVariations,
    List<ProductAttributesModel>? productAttributes,
    List<CategoryModel>? categories,
    BrandModel? brand,
    ProductType? productType,
    bool? isFeatured,
    List<BrandModel>? brands,
    bool? isEditingLoading = false,
    bool? isCreatedLoading = false,
  }) => CreateProductStates(
    isLoading: isLoading ?? this.isLoading,
    isEditingLoading: isEditingLoading ?? this.isEditingLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    successMessage: successMessage ?? this.successMessage,
    product: product ?? this.product,
    thumbnail: thumbnail ?? this.thumbnail,
    additionalImages: additionalImages ?? this.additionalImages,
    productCategories: productCategories ?? this.productCategories,
    productVariations: productVariations ?? this.productVariations,
    productAttributes: productAttributes ?? this.productAttributes,
    categories: categories ?? this.categories,
    brand: brand ?? this.brand,
    productType: productType ?? this.productType,
    isFeatured: isFeatured ?? this.isFeatured,
    brands: brands ?? this.brands,
    isCreatedLoading: isCreatedLoading ?? this.isCreatedLoading,
  );
}
