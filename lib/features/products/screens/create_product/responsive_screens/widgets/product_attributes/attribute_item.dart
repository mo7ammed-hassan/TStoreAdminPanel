import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/product/product_attributes_model.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';

class AttributeItem extends StatelessWidget {
  final ProductAttributesModel attribute;
  final int index;
  final bool isDark;

  const AttributeItem({
    super.key,
    required this.attribute,
    required this.index,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      ),
      child: ListTile(
        key: ValueKey('attr_${attribute.name}_$index'),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.xs,
        ),
        title: Text(attribute.name),
        subtitle: Text(attribute.values.map((e) => e.trim()).toString()),
        trailing: IconButton(
          onPressed: () => cubit.deleteProductAttribute(index),
          icon: const Icon(Iconsax.trash, color: AppColors.error),
        ),
      ),
    );
  }
}
