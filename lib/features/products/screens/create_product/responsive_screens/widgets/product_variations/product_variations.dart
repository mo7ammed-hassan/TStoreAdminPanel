import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/product/product_variation_model.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_variations/variation_item.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    final isSingleProduct = context.select<CreateProductCubit, bool>(
      (cubit) => cubit.state.productType == ProductType.single,
    );

    return isSingleProduct
        ? const SizedBox.shrink()
        : const _VariationsSection();
  }
}

class _VariationsSection extends StatelessWidget {
  const _VariationsSection();

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const _VariationsListView(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Product Variations',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        TextButton(
          onPressed:
              () =>
                  context.read<CreateProductCubit>().deleteProductVariations(),
          child: const Text('Remove Variations'),
        ),
      ],
    );
  }
}

class _VariationsListView extends StatelessWidget {
  const _VariationsListView();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      CreateProductCubit,
      CreateProductStates,
      List<ProductVariationModel>
    >(
      selector: (state) => state.productVariations ?? [],
      builder: (context, variations) {
        if (variations.isEmpty) return const _EmptyVariationsMessage();

        return Form(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: variations.length,
            separatorBuilder:
                (_, __) => const SizedBox(height: AppSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final variation = variations[index];
              return VariationItem(
                key: ValueKey(variations[index].id),
                index: index,
                variation: variation,
              );
            },
          ),
        );
      },
    );
  }
}

class _EmptyVariationsMessage extends StatelessWidget {
  const _EmptyVariationsMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImages.colorImage, width: 130, height: 50),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          'There are no variations added yet.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
