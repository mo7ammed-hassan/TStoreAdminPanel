import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';

abstract class BaseProductScreen<T> extends StatelessWidget {
  const BaseProductScreen({super.key, required this.buildContent});

  final Widget buildContent;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProductCubit, CreateProductStates>(
      listener: handleStateChanges,
      child: buildContent,
    );
  }

  void handleStateChanges(BuildContext context, CreateProductStates state) {
    if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
      Loaders.warningSnackBar(title: 'Error', message: state.errorMessage!);
    }

    if (state.successMessage != null && state.successMessage!.isNotEmpty) {
      Loaders.successSnackBar(
        title: 'Congratulations',
        message:
            state.successMessage ??
            'Product ${state.isEditingLoading ? 'Updated' : 'Created'} successfully',
      );
    }

    if (state.isCreatedLoading) {
      CustomDialogs.showCircularLoader();
    } else {
      CustomDialogs.hideLoader();
    }
  }
}
