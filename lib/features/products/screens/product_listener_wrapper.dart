import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';

class ProductListenerWrapper extends StatelessWidget {
  const ProductListenerWrapper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProductCubit, CreateProductStates>(
      listenWhen:
          (prev, current) =>
              prev.isLoading != current.isLoading ||
              prev.isEditingLoading != current.isEditingLoading ||
              prev.errorMessage != current.errorMessage ||
              prev.successMessage != current.successMessage,
      listener: (context, state) => _handleStateChanges(context, state),
      child: child,
    );
  }

  void _handleStateChanges(BuildContext context, CreateProductStates state) {
    _handleLoaders(context, state);
    _handleFeedback(context, state);
  }

  void _handleLoaders(BuildContext context, CreateProductStates state) {
    if (state.isLoading || state.isEditingLoading) {
      CustomDialogs.showCircularLoader();
    } else {
      CustomDialogs.hideLoader();
    }
  }

  void _handleFeedback(BuildContext context, CreateProductStates state) {
    final errorMessage = state.errorMessage;
    final successMessage = state.successMessage;

    if (errorMessage?.isNotEmpty ?? false) {
      Loaders.warningSnackBar(
        title: 'Error',
        message: errorMessage ?? 'An unknown error occurred',
      );
    }

    if (successMessage?.isNotEmpty ?? false) {
      Loaders.successSnackBar(
        title: 'Success',
        message: successMessage ?? 'Operation completed successfully',
      );
    }
  }
}
