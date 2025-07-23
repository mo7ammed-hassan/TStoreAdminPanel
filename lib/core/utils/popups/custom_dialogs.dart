import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';

class CustomDialogs {
  static Future<bool?> defaultDialog({
    required BuildContext context,
    String title = 'Removal Confirmation',
    String content =
        'Remove this data will delete all related data. Are you sure?',
    String confirmText = 'Remove',
    String cancelText = 'Cancel',
    Function()? onConfirm,
    Function()? onCancel,
  }) {
    return showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            content: Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              cancelText == ''
                  ? const SizedBox()
                  : TextButton(
                    onPressed:
                        onCancel ??
                        () => context.popPage(context, result: false),
                    child: Text(cancelText),
                  ),
              TextButton(
                onPressed:
                    onConfirm ?? () => context.popPage(context, result: true),
                child: Text(confirmText),
              ),
            ],
          ),
    );
  }
}
