import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

sealed class EditBrandStates {}

class EditBrandInitialState extends EditBrandStates {}

class EditBrandLoadingState extends EditBrandStates {}

class EditBrandSuccessState extends EditBrandStates {
  final String message;
  EditBrandSuccessState({required this.message});
}

class EditBrandCompletedState extends EditBrandStates {
  final BrandModel brand;
  EditBrandCompletedState({required this.brand});
}

class EditBrandErrorState extends EditBrandStates {
  final String errorMessage;
  EditBrandErrorState({required this.errorMessage});
}

class ToggleFeatured extends EditBrandStates {
  final bool isFeatured;
  ToggleFeatured(this.isFeatured);
}

class ToggleCategorySelectionState extends EditBrandStates {
  final List<CategoryModel> selectedCategories;
  ToggleCategorySelectionState(this.selectedCategories);
}

class PickImageState extends EditBrandStates {
  final String imageUrl;
  PickImageState(this.imageUrl);
}

class FetchCategoriesState extends EditBrandStates {
  final List<CategoryModel> categories;
  FetchCategoriesState(this.categories);
}

