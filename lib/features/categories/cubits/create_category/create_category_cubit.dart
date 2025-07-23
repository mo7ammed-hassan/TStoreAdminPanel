import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/helpers/media_picker_helper.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/domain/repositories/category/category_repo.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/create_category/create_category_state.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class CreateCategoryCubit extends Cubit<CreateCategoryState> {
  CreateCategoryCubit(this.categoryRepo) : super(CreateCategoryInitial()){
    fetchCategories();
  }

  final CategoryRepo categoryRepo;

  // Form
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  CategoryModel selectedParent = CategoryModel.empty();
  String? imageUrl = '';
  bool isFeatured = false;
  List<CategoryModel> categories = [];

  // Create Category
  Future<void> createCategory() async {
    // check if form is valid
    if (!formKey.currentState!.validate()) return;

    if (!isClosed) emit(CreateCategoryLoadingState());
    CustomDialogs.showCircularLoader();

    // check Internet connection
    // final isConnected = await NetworkManager.instance.isConnected();
    // if (!isConnected) {
    //   CustomDialogs.hideLoader();
    //   Loaders.errorSnackBar(title: 'Error', message: 'No Internet Connection');
    //   return;
    // }

    // map data
    final category = CategoryModel(
      id: '',
      name: nameController.text.trim(),
      image: imageUrl,
      isFeatured: isFeatured,
      parentId: selectedParent.id!,
      createdAt: DateTime.now(),
    );

    var result = await categoryRepo.createCategory(category);
    if (isClosed) return;

    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        if (!isClosed) emit(CreateCategoryFailureState(error));
      },
      (id) async {
        category.id = id;

        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Category created successfully.',
        );

        getIt<MediaCubit>().reset();

        if (!isClosed) emit(CreateCategorySuccessState(category));
      },
    );
  }

  // pick thumbnail image from media
  Future<void> pickImage() async {
    imageUrl = await MediaPickerHelper.pickAndUpdateImage<PickImageState>(
      imageUrl,
      (selectedImage) => emit(PickImageState(selectedImage ?? '')),
    );
  }

  // toggle isFeatured
  void toggleIsFeatured(bool? value) {
    isFeatured = value ?? false;
    if (!isClosed) emit(ToggleFeatured(isFeatured));
  }

   Future<void> fetchCategories() async {
    var result = await getIt<CategoryCubit>().fetchItems();
    result.fold((error) => null, (data) {
      categories = data;
      emit(FetchCategoriesState(categories));
    });
  }

  void resetForm() {
    nameController.clear();
    imageUrl = '';
    isFeatured = false;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
