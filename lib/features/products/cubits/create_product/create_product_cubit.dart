import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/extensions/list_extensions.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_attributes_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_variation_model.dart';
import 'package:t_store_admin_panel/domain/repositories/products/product_repo_impl.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/features/products/widgets/product_dialogs/product_dialogs.dart';

class CreateProductCubit extends Cubit<CreateProductStates> {
  CreateProductCubit() : super(const CreateProductStates());

  final ProductRepoImpl productRepoImpl = getIt<ProductRepoImpl>();
  // ---Media Cubit---
  final mediaCubit = getIt<MediaCubit>();
  final mediaActionCubit = getIt<MediaActionCubit>();

  bool isEditing = false;

  void resetAllSelectedImages() {
    mediaActionCubit.resetCheckBox();
    mediaActionCubit.resetSelectedImages();
  }

  /// --- Initialize ---
  void init(ProductModel productModel) {
    isEditing = true;
    loadSelectedCategories(productModel.id!);

    // Clear existing controllers first
    _resetAllVariationData();

    _markImagesSelected(
      productModel.images ?? [],
      productModel.thumbnail ?? '',
    );

    // base section
    productTitleController.text = productModel.title;
    productDescriptionController.text = productModel.description ?? '';
    if (productModel.productType == ProductType.single.toString()) {
      priceController.text = productModel.price.toString();
      discountController.text = productModel.salePrice.toString();
      stockController.text = productModel.stock.toString();
    }

    // init brand controller
    selectedBrand = productModel.brand ?? BrandModel.empty();
    brandController.text = selectedBrand.name;

    // init thumbnail image & additional images
    thumbnail = productModel.thumbnail ?? '';
    additionalImages = productModel.images ?? [];

    // init product type
    productType =
        productModel.productType == ProductType.variable.toString()
            ? ProductType.variable
            : ProductType.single;

    // init product visibility
    isVisible = productModel.isFeatured ?? true;
    productVisibility =
        isVisible ? ProductVisibility.pubblished : ProductVisibility.hidden;

    // init product attributes
    productAttributes = productModel.productAttributes ?? [];

    // init product variations
    productVariations = productModel.productVariations ?? [];

    // init product variations controllers
    for (ProductVariationModel variation
        in productModel.productVariations ?? []) {
      final Map<ProductVariationModel, TextEditingController> stockControllers =
          {variation: TextEditingController()};
      final Map<ProductVariationModel, TextEditingController> priceControllers =
          {variation: TextEditingController()};
      final Map<ProductVariationModel, TextEditingController>
      salePriceControllers = {variation: TextEditingController()};
      final Map<ProductVariationModel, TextEditingController>
      descriptionControllers = {variation: TextEditingController()};

      stockControllersList.add(stockControllers);
      priceControllersList.add(priceControllers);
      salePriceControllersList.add(salePriceControllers);
      descriptionControllersList.add(descriptionControllers);

      // set the initial values for the controllers
      stockControllers[variation]?.text = variation.stock.toString();
      priceControllers[variation]?.text = variation.price.toString();
      salePriceControllers[variation]?.text = variation.salePrice.toString();
      descriptionControllers[variation]?.text = variation.description ?? '';
    }

    emit(
      CreateProductStates(
        thumbnail: thumbnail,
        additionalImages: additionalImages ?? [],
        productType: productType,
        isFeatured: isVisible,
        productAttributes: productAttributes,
        productVariations: productVariations,
        categories: selectedCategories,
        brand: selectedBrand,
        product: productModel,
      ),
    );
  }

  Future<void> loadSelectedCategories(String productId) async {
    var result = await productRepoImpl.getProductCategories(productId);

    result.fold((error) => null, (data) async {
      final cubit = getIt<CategoryCubit>();
      if (cubit.allItems.isEmpty) await cubit.fetchItems();

      selectedCategories =
          cubit.allItems
              .where(
                (category) =>
                    data.map((e) => e.categoryId).contains(category.id),
              )
              .toList();

      emit(state.copyWith(categories: List.from(selectedCategories)));
    });
  }

  void _markImagesSelected(List<String> productImages, String thumbnail) async {
    mediaCubit.selectedPath = MediaCategory.products;
    await mediaCubit.fetchImagesFromDatabase(10);

    final List<ImageModel> allProductImages = mediaCubit.allProductImages;

    // for (var image in productImages) {
    //   selectedImages.firstWhere((element) => element.url == image).isSelected =
    //       true;
    // }

    List<ImageModel> selectedImages = [];
    for (var image in productImages) {
      selectedImages.add(
        allProductImages.firstWhere(
          (element) => element.url.trim() == image.trim(),
        ),
      );
    }
    mediaActionCubit.initSelectedImages(selectedImages, MediaCategory.products);
  }

  /// --- End Initialize --- ///
  /// --------------------------------------------------------------- ///

  // ---Form Keys---
  final GlobalKey<FormState> basicInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> stockAndPriceFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> attributesFormKey = GlobalKey<FormState>();

  /// -----------------------------------------------------------------//

  /// ---Controllers---
  /// -- Basic Info Form Controllers ---
  final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();

  /// -- Stock and Price Form Controllers ---
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  /// -- Brand Controller ---
  TextEditingController brandController = TextEditingController();

  /// -- Attributes Form Controllers ---
  final TextEditingController attributeNameController = TextEditingController();
  final TextEditingController attributeValueController =
      TextEditingController();

  ///--------------------------------------------------------------------------///

  /// ---product thumbnail & images---
  String? thumbnail = '';
  List<String>? additionalImages = [];

  ///--------------------------------------------------------------------------///

  /// ---Product Brand & Categories---
  BrandModel selectedBrand = BrandModel.empty();
  List<CategoryModel> selectedCategories = [];

  ///--------------------------------------------------------------------------///

  /// ---visibility & product type---
  bool isVisible = true;
  ProductVisibility productVisibility = ProductVisibility.pubblished;
  ProductType productType = ProductType.single;

  ///--------------------------------------------------------------------------///

  /// ---Product Attributes && Product Variations---
  List<ProductAttributesModel> productAttributes = [];
  List<ProductVariationModel> productVariations = [];

  /// --------------------------------------------------------------------------///

  // Lists to store colntrollers for each product variation
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
  salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>>
  descriptionControllersList = [];

  /// --------------------------------------------------------------------------///

  /// --- Stock --
  int get totalStock => productVariations.fold<int>(
    0,
    (previousValue, element) => previousValue + element.stock,
  );

  int getStock() {
    if (stockController.text.isEmpty) {
      return totalStock;
    }
    return int.parse(stockController.text);
  }

  /// --- Triggered product type  && visibility changes ---
  void changeProductType(ProductType productType) {
    if (this.productType == productType) return;

    this.productType = productType;
    emit(state.copyWith(productType: productType));
  }

  // --- Triggered when product visibility changes ---
  void changeProductVisibility(ProductVisibility productVisibility) {
    if (productVisibility == ProductVisibility.pubblished) {
      isVisible = true;
    } else if (productVisibility == ProductVisibility.hidden) {
      isVisible = false;
    }
    this.productVisibility = productVisibility;
    emit(state.copyWith(isFeatured: isVisible));
  }

  /// --------------------------------------------------------------------------///

  /// --- Select Thumbnail Image ---
  void selectThumbnailImage() async {
    // Reset selected images  // mediaActionCubit.resetCheckBox();
    if (isEditing) {
      final ImageModel selectedImage = mediaCubit.allProductImages.firstWhere(
        (element) => element.url.trim() == thumbnail!.trim(),
      );

      mediaActionCubit.toggleImageCheckBox(selectedImage, true, false);
    } else {
      mediaActionCubit.resetSelectedImages();
    }

    // trigger selection of images
    List<ImageModel>? selectedImages =
        await mediaCubit.selectionImagesFromMedia();

    // Handle selected images
    if (selectedImages?.isNotEmpty ?? false) {
      // set the selected image to the main image
      ImageModel selectedImage = selectedImages!.first;
      // update selected thumbnail image
      thumbnail = selectedImage.url;

      // // if(!isClosed) emit selected thumbnail image
      // if (!isClosed) emit(CreateProductStates(thumbnail: thumbnail));

      // because we select thumbnail image only once
      // we should reset the checkbox for this image
      mediaActionCubit.toggleImageCheckBox(selectedImage, false, false);

      if (!isClosed) emit(state.copyWith(thumbnail: thumbnail));
    }
  }

  /// -- Select Additional Images --
  void selectAdditionalImage() async {
    mediaActionCubit.pickc();
    // pass select additional images from bottom sheet
    final List<ImageModel>? selectedImages = await mediaCubit
        .selectionImagesFromMedia(
          allowMultiSelection: true,
          selectedImagesUrls: additionalImages ?? [],
        );

    // Handle selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalImages = List.from(selectedImages.map((e) => e.url));
      if (!isClosed) {
        emit(state.copyWith(additionalImages: additionalImages ?? []));
      }
    }
  }

  /// -- Remove Additional Image --
  void removeImage(int index, String url) async {
    if (additionalImages == null || !additionalImages!.isValidIndex(index)) {
      return;
    }
    // get image index
    additionalImages!.removeAt(index);
    mediaActionCubit.resetSingleImageCheckBox(url);
    if (!isClosed) {
      emit(state.copyWith(additionalImages: List.from(additionalImages ?? [])));
    }
  }

  ///---------------------------------------------------------------------------------------------///

  /// ---Product attributes (Add & Delete)---
  // add product attribute
  void addProductAttribute() {
    if (!validateAttributes()) return;

    // create product attribute
    final productAttribute = ProductAttributesModel(
      name: attributeNameController.text,
      values: attributeValueController.text.trim().split('|').toList(),
    );
    // check if the attribute already exists
    if (!productAttributes.contains(productAttribute)) {
      productAttributes.add(productAttribute);
    } else {
      // show error message
      emit(state.copyWith(errorMessage: 'This attribute already exists'));
      return;
    }

    emit(state.copyWith(productAttributes: [...productAttributes]));
    // reset attribute form fields
    attributesFormKey.currentState?.reset();
  }

  // delete product attribute
  void deleteProductAttribute(int index) async {
    assert(
      index >= 0 &&
          productAttributes.isNotEmpty &&
          index < productAttributes.length,
    );

    if (productVariations.isNotEmpty) {
      return emit(
        state.copyWith(
          errorMessage: 'Please delete all product variations first',
        ),
      );
    }

    final confirmDialogResult =
        await ProductConfirmationDialogs.showDeleteProductAttributeDialog();

    if (confirmDialogResult) {
      productAttributes.removeAt(index);
      emit(state.copyWith(productAttributes: List.from(productAttributes)));
    }
  }

  ///---------------------------------------------------------------------------------------------///

  /// --- Product variations (Add & Delete) ---
  // add product variation
  void generateProductVariations() async {
    if (productAttributes.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please add at least one product attribute',
        ),
      );
      return;
    }

    final confirmDialogResult =
        await ProductConfirmationDialogs.showAddVariationsDialog();

    if (confirmDialogResult) {
      final List<ProductVariationModel> generatedVariations = [];

      if (productAttributes.isNotEmpty) {
        // get all combinations of attributes
        final List<List<String>> combinations = getCombinations(
          productAttributes.map((e) => e.values).toList(),
        );

        // generate variations from combinations
        for (final combination in combinations) {
          final Map<String, String> attributeValues = Map.fromIterables(
            productAttributes.map((e) => e.name),
            combination,
          );

          final ProductVariationModel variation = ProductVariationModel(
            id: UniqueKey().toString(),
            attributeValues: attributeValues,
          );

          // create controllers
          final Map<ProductVariationModel, TextEditingController>
          stockControllers = {};
          final Map<ProductVariationModel, TextEditingController>
          priceControllers = {};
          final Map<ProductVariationModel, TextEditingController>
          salePriceControllers = {};
          final Map<ProductVariationModel, TextEditingController>
          descriptionControllers = {};

          stockControllers[variation] = TextEditingController();
          priceControllers[variation] = TextEditingController();
          salePriceControllers[variation] = TextEditingController();
          descriptionControllers[variation] = TextEditingController();

          stockControllersList.add(stockControllers);
          priceControllersList.add(priceControllers);
          salePriceControllersList.add(salePriceControllers);
          descriptionControllersList.add(descriptionControllers);

          // set the generated variation to the product variations
          // add another faild
          productVariations.add(variation);
        }
      }

      productVariations.addAll(generatedVariations);
      emit(state.copyWith(productVariations: List.from(productVariations)));
    }
  }

  /// --- Generate Variations ---
  /// This function generates all possible combinations of attributes
  List<List<String>> getCombinations(List<List<String>> combinations) {
    final List<List<String>> result = [];

    // start combining
    combine(combinations, [], 0, result);

    return result;
  }

  // recursive function to combine the attributes
  // [[Red,Green],[EU:30,EU:40]]
  void combine(
    List<List<String>> combinations,
    List<String> current,
    int index,
    List<List<String>> result,
  ) {
    if (index == combinations.length) {
      result.add(List.from(current));
      return;
    }

    // iterate over the current combination of attributes // [[Red,Green],[EU:30,EU:40]]
    for (final item in combinations[index]) {
      final List<String> newCombination = List.from(current)..add(item);

      // recursive call
      combine(combinations, newCombination, index + 1, result);
    }
  }

  // --- Select Product Variation Image ---
  void selectProductVariationImage(ProductVariationModel variation) async {
    // Reset selected images
    mediaActionCubit.resetCheckBox();

    // trigger selection of images
    List<ImageModel>? selectedImages =
        await mediaCubit.selectionImagesFromMedia();

    // Handle selected images
    if (selectedImages?.isNotEmpty ?? false) {
      // set the selected image to the main image
      ImageModel selectedImage = selectedImages!.first;
      // update selected thumbnail image
      variation.image = selectedImage.url;

      // if(!isClosed) emit selected thumbnail image
      if (!isClosed) {
        emit(state.copyWith(productVariations: List.from(productVariations)));
      }

      // because we select thumbnail image only once .. we must reset the checkbox for this image
      mediaActionCubit.toggleImageCheckBox(selectedImage, false, false);
    } else {
      variation.image = '';
      emit(state.copyWith(productVariations: List.from(productVariations)));
    }
  }

  // delete product variations
  void deleteProductVariations() async {
    if (productVariations.isEmpty) {
      return emit(state.copyWith(errorMessage: 'No variations to delete'));
    }
    final confirmDialogResult =
        await ProductConfirmationDialogs.showDeleteVariationsDialog();

    if (confirmDialogResult) {
      for (var variation in productVariations) {
        if (variation.image.isNotEmpty) {
          mediaActionCubit.resetSingleImageCheckBox(variation.image);
          mediaCubit.removeSelectedImage(variation.image);
          variation.image = '';
        }
      }
      _resetAllVariationData();

      emit(state.copyWith(productVariations: []));
    }
  }

  ///---------------------------------------------------------------------------------------------///

  /// --- Trigger Category Selection & Brand Selection ---
  void triggerCategorySelection(List<CategoryModel> categories) {
    selectedCategories
      ..clear()
      ..addAll(categories);
  }

  void triggerBrandSelection(BrandModel suggestion) {
    selectedBrand = suggestion;
    brandController.text = suggestion.name;
  }

  ///---------------------------------------------------------------------------------------------///

  /// --- Create Product || Update Product ---
  Future<void> createOrUpdateProduct() async {
    if (isEditing) {
      await updateProduct();
    } else {
      await createProduct();
    }
  }

  Future<void> createProduct() async {
    if (!validateAllProductData()) {
      return;
    }

    emit(state.copyWith(isEditingLoading: true));

    /// --- Create Product Model ---
    final product = ProductModel(
      id: '',
      title: productTitleController.text,
      description: productDescriptionController.text,
      price: double.tryParse(priceController.text) ?? 0.0,
      salePrice: double.tryParse(discountController.text) ?? 0.0,
      stock: getStock(),
      thumbnail: thumbnail,
      images: additionalImages,
      isFeatured: isVisible,
      brand: selectedBrand,
      createdAt: DateTime.now(),
      productType: productType.toString(),
      productAttributes: productAttributes,
      productVariations: productVariations,
      sku: '',
    );

    final result = await productRepoImpl.createProductCategory(
      product,
      selectedCategories,
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          errorMessage: 'Failed to create product ${error.toString()}',
        ),
      ),
      (productId) {
        resetAllFields();
        mediaActionCubit.resetSelectedImages();
        emit(
          CreateProductStates(
            successMessage: 'Product created successfully',
            categories: selectedCategories,
          ),
        );
      },
    );
  }

  Future<void> updateProduct() async {
    if (!validateAllProductData()) {
      return;
    }

    emit(state.copyWith(isEditingLoading: true));

    /// --- Update Product Model ---
    final product = ProductModel(
      id: state.product?.id ?? '',
      title: productTitleController.text,
      description: productDescriptionController.text,
      price: double.tryParse(priceController.text) ?? 0.0,
      salePrice: double.tryParse(discountController.text) ?? 0.0,
      stock: getStock(),
      thumbnail: thumbnail,
      images: additionalImages,
      isFeatured: isVisible,
      brand: selectedBrand,
      updatedAt: DateTime.now(),
      productType: productType.toString(),
      productAttributes: productAttributes,
      productVariations: productVariations,
      sku: '',
    );

    final result = await productRepoImpl.updateProductCategory(
      product,
      selectedCategories,
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          errorMessage: 'Failed to update product ${error.toString()}',
        ),
      ),
      (productId) {
        emit(
          state.copyWith(
            successMessage: 'Product updated successfully',
            categories: selectedCategories,
          ),
        );
      },
    );
  }

  /// ----------------------------------------------------------------------------- ///

  /// --- Validation ---
  bool validateBasicInfo() =>
      basicInfoFormKey.currentState?.validate() ?? false;
  bool validateStockAndPrice() {
    return productType == ProductType.single
        ? stockAndPriceFormKey.currentState?.validate() ?? false
        : true;
  }

  bool validateAttributes() =>
      attributesFormKey.currentState?.validate() ?? false;

  bool validateAllBasicForms() =>
      validateBasicInfo() && validateStockAndPrice();

  /// valiate thimbnail image & additional images & brand & categories
  bool validateBrand() =>
      selectedBrand.id != null &&
      selectedBrand.id != '' &&
      selectedBrand != BrandModel.empty();
  bool validateAdditionalImages() =>
      additionalImages != null && additionalImages!.isNotEmpty;
  bool validateCategories() => selectedCategories.isNotEmpty;
  bool validateThumbnail() => thumbnail!.isNotEmpty && thumbnail != '';
  bool validateVariations() {
    if (productType == ProductType.variable && productVariations.isEmpty) {
      emit(
        state.copyWith(
          errorMessage:
              'Please add at least one variation for variable product',
        ),
      );
      return false;
    }

    if (productType == ProductType.variable) {
      final variationCheckFailed = productVariations.any(
        (element) =>
            element.price.isNaN ||
            element.price <= 0 ||
            (element.salePrice.isNaN && element.salePrice != 0) ||
            element.salePrice < 0 ||
            element.stock.isNaN ||
            element.stock < 0 ||
            element.image.isEmpty ||
            element.description == null ||
            element.description!.isEmpty,
      );

      if (variationCheckFailed) {
        emit(
          state.copyWith(
            errorMessage:
                'Please fill all required fields for each variation (price, stock, image, description)',
          ),
        );
        return false;
      }
    }
    return true;
  }

  bool validateAllProductData() {
    // Validate title & description and price & stock if product type is single
    if (!validateAllBasicForms()) {
      return false;
    }

    if (!validateThumbnail()) {
      emit(state.copyWith(errorMessage: 'Please select a thumbnail image'));
      return false;
    }

    if (!validateAdditionalImages()) {
      emit(
        state.copyWith(
          errorMessage: 'Please select at least one additional image',
        ),
      );
      return false;
    }

    if (!validateBrand()) {
      emit(state.copyWith(errorMessage: 'Please select a brand'));
      return false;
    }

    if (!validateCategories()) {
      emit(state.copyWith(errorMessage: 'Please select at least one category'));
      return false;
    }

    // validation variations
    if (!validateVariations()) {
      return false;
    }

    return true;
  }

  ///-----------------------------------------------------------------------------///

  // -- Reset all variation form fields --
  void _resetAllVariationData() {
    // Clear all controllers first
    for (final controllerMap in [
      ...stockControllersList,
      ...priceControllersList,
      ...salePriceControllersList,
      ...descriptionControllersList,
    ]) {
      for (var c in controllerMap.values) {
        c.dispose();
      }
    }

    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();
    productVariations.clear();
  }

  /// --- Reset All Fields ---
  void resetAllFields() {
    // Clear controllers
    productTitleController.clear();
    productDescriptionController.clear();
    priceController.clear();
    discountController.clear();
    stockController.clear();
    brandController.clear();
    attributeNameController.clear();
    attributeValueController.clear();

    // Reset media selections
    thumbnail = '';
    additionalImages = [];
    mediaActionCubit.resetSelectedImages();

    // Reset selections
    selectedBrand = BrandModel.empty();
    // selectedCategories = [];
    productAttributes = [];

    // Reset product type and visibility
    productType = ProductType.single;
    productVisibility = ProductVisibility.pubblished;
    isVisible = true;

    // Reset variations
    _resetAllVariationData();

    // Reset form states
    basicInfoFormKey.currentState?.reset();
    stockAndPriceFormKey.currentState?.reset();
    attributesFormKey.currentState?.reset();

    // Clear any error/success messages
    emit(const CreateProductStates());
  }

  /// --- Close ---
  @override
  Future<void> close() {
    productTitleController.dispose();
    productDescriptionController.dispose();
    priceController.dispose();
    discountController.dispose();
    stockController.dispose();
    attributeNameController.dispose();
    attributeValueController.dispose();
    _resetAllVariationData();
    return super.close();
  }
}
