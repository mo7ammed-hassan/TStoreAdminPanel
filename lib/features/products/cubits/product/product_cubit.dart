import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/domain/repositories/products/product_repo_impl.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepo) : super(ProductInitial()) {
    init();
  }
  final GenericRepository<ProductModel> productRepo;
  final ProductRepoImpl productRepoImpl = getIt<ProductRepoImpl>();

  final List<ProductModel> allProducts = [];
  final List<ProductModel> filteredProducts = [];
  final List<bool> selectedRows = [];
  String? selectedThumbnailImageUrl = '';
  List<String> additionalProductImagesUrls = [];

  // instance from media cubit
  final mediaCubit = getIt<MediaCubit>();
  final mediaActionCubit = getIt<MediaActionCubit>();

  /// -- init--
  void init() async {
    await fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (!isClosed) emit(ProductsLoadingState());

    var result = await productRepo.fetchItems();
    result.fold(
      (error) {
        if (!isClosed) emit(ProductErrorState(error));
      },
      (data) {
        allProducts
          ..clear
          ..addAll(data);
        selectedRows
          ..clear()
          ..addAll(List.generate(data.length, (index) => false));
        if (!isClosed) emit(ProductsLoadedState(data));
      },
    );
  }

  /// -- show confirmation dialog for deleting --
  Future<void> confirmDeleteDialog(ProductModel product) async {
    final result = await CustomDialogs.showConfirmationDialog(
      title: 'Delete Item',
      message: 'Are you sure you want to delete this Item?',
      confirmButtonText: 'Delete',
      cancelButtonText: 'Cancel',
    );

    if (result) {
      await deleteItemOnConfirmation(product);
    }
  }

  // -- delete item on confirmation --
  Future<void> deleteItemOnConfirmation(ProductModel product) async {
    CustomDialogs.showCircularLoader();

    final result = await productRepoImpl.deleteProductCategory(product.id!);
    if (isClosed) return;

    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to delete item.\n$error',
        );
        if (!isClosed) emit(DeleteItemFailureState(error));
      },
      (_) async {
        removeItemFromList(product);

        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          title: 'Item Deleted',
          message: 'Your item has been deleted successfully.',
        );

        if (!isClosed) emit(ProductsLoadedState(List.from(allProducts)));
      },
    );
  }

  /// -- remove item from list --
  void removeItemFromList(ProductModel item) {
    final index = allProducts.indexOf(item);
    // // Remove from local storage
    // cacheStorageManagement.deleteItem(allProducts.indexOf(item));

    // Remove from lists
    allProducts.remove(item);
    selectedRows.removeAt(index);

    if (!isClosed) emit(ProductsLoadedState(List.from(allProducts)));
  }

  /// -- search quary --
  void searchQuary(String quary) {
    filteredProducts.clear();
    if (quary.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts
            .where(
              (element) =>
                  element.title.toLowerCase().contains(quary.toLowerCase()),
            )
            .toList(),
      );
    }
    if (!isClosed) emit(ProductsLoadedState((List.from(filteredProducts))));
  }
}
