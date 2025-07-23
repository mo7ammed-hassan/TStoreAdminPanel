import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/core/utils/popups/custom_dialogs.dart';

class ProductConfirmationDialogs {
  const ProductConfirmationDialogs._();

  /// This class contains methods to show different types of dialogs
  /// related to products, such as adding a new product or updating an existing one.
  /// It uses the [CustomDialogs] class to show the dialogs.
  /// The dialogs are shown using the [AppContext] to get the current context.
  /// The dialogs include:

  // show delete product attribute dialog
  static Future<bool> showDeleteProductAttributeDialog() async {
    return await CustomDialogs.defaultDialog(
          context: AppContext.context,
          title: 'Delete Product Attribute',
          content: 'Are you sure you want to delete this attribute?',
          confirmText: 'Delete',
          onCancel:
              () =>
                  AppContext.context.popPage(AppContext.context, result: false),
        ) ??
        false;
  }

  // show delete product dialog
  static Future<bool> showDeleteProductDialog() async {
    return await CustomDialogs.defaultDialog(
          context: AppContext.context,
          title: 'Delete Product',
          content: 'Are you sure you want to delete this product?',
          confirmText: 'Delete',
          onCancel:
              () =>
                  AppContext.context.popPage(AppContext.context, result: false),
        ) ??
        false;
  }

  // show delete variations dialog
  static Future<bool> showDeleteVariationsDialog() async {
    return await CustomDialogs.defaultDialog(
          context: AppContext.context,
          title: 'Delete Variations',
          content: 'Are you sure you want to delete these variations?',
          confirmText: 'Delete',
          onCancel:
              () =>
                  AppContext.context.popPage(AppContext.context, result: false),
        ) ??
        false;
  }

  static Future<bool> showAddVariationsDialog() async {
    return await CustomDialogs.defaultDialog(
          context: AppContext.context,
          title: 'Generate Variations',
          content:
              'Are you sure you want to add these variations?\nonce added, you can not add more variations',
          confirmText: 'Generate',
          onCancel:
              () =>
                  AppContext.context.popPage(AppContext.context, result: false),
        ) ??
        false;
  }
}
