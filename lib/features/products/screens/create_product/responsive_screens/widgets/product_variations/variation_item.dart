import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/product/product_variation_model.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';

class VariationItem extends StatelessWidget {
  const VariationItem({
    super.key,
    required this.variation,
    required this.index,
  });

  final ProductVariationModel variation;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return ExpansionTile(
      key: ValueKey(variation.id),
      collapsedBackgroundColor: isDark ? AppColors.dark : AppColors.lightGrey,
      backgroundColor: isDark ? AppColors.dark : AppColors.lightGrey,
      childrenPadding: const EdgeInsets.all(AppSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      ),
      title: Text(
        variation.attributeValues.entries
            .map((e) => '${e.key}: ${e.value}')
            .join(', '),
      ),

      children: [
        _VariationImage(variation: variation, index: index),
        const SizedBox(height: AppSizes.spaceBtwInputFields),
        _VariationStockPriceRow(variation: variation, index: index),
        const SizedBox(height: AppSizes.spaceBtwInputFields),
        _VariationDescriptionField(variation: variation, index: index),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }
}

class _VariationImage extends StatelessWidget {
  const _VariationImage({required this.index, required this.variation});

  final int index;
  final ProductVariationModel variation;

  @override
  Widget build(BuildContext context) {
    return UploaderImage<CreateProductCubit, CreateProductStates>(
      imageSelector: (state) {
        final variations = state.productVariations;
        if (variations != null && index < variations.length) {
          return variations[index].image;
        }
        return state.productVariations?[index].image;
      },
      onImageChanged:
          () => context.read<CreateProductCubit>().selectProductVariationImage(
            variation,
          ),
    );
  }
}

class _VariationStockPriceRow extends StatelessWidget {
  final ProductVariationModel variation;
  final int index;

  const _VariationStockPriceRow({required this.variation, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: cubit.stockControllersList[index][variation],
            onChanged: (value) => variation.stock = int.tryParse(value) ?? 0,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Stock',
              hintText: 'Add Stock, only numbers allowed',
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwInputFields),
        Expanded(
          child: TextFormField(
            controller: cubit.priceControllersList[index][variation],
            onChanged:
                (value) => variation.price = double.tryParse(value) ?? 0.0,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Price',
              hintText: 'Price with up-to 2 decimal places',
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwInputFields),
        Expanded(
          child: TextFormField(
            controller: cubit.salePriceControllersList[index][variation],
            onChanged:
                (value) => variation.salePrice = double.tryParse(value) ?? 0.0,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              labelText: 'Discount Price',
              hintText: 'Price with up-to 2 decimal places',
            ),
          ),
        ),
      ],
    );
  }
}

class _VariationDescriptionField extends StatelessWidget {
  final ProductVariationModel variation;
  final int index;

  const _VariationDescriptionField({
    required this.variation,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        context
            .read<CreateProductCubit>()
            .descriptionControllersList[index][variation];

    return TextFormField(
      controller: controller,
      onChanged: (value) => variation.description = value,
      decoration: const InputDecoration(
        labelText: 'Description',
        hintText: 'Add description of this variation...',
      ),
    );
  }
}
