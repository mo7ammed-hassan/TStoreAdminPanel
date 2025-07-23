import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/features/brands/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';

class ProductBrands extends StatelessWidget {
  const ProductBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),
          _BrandSelectionField(),
        ],
      ),
    );
  }
}

class _BrandSelectionField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<CreateProductCubit>();

    return BlocProvider(
      create: (context) => getIt<BrandCubit>(),
      child: BlocBuilder<BrandCubit, BaseDataTableStates>(
        builder: (context, state) {
          if (state is DataTableLoadingState) {
            return const ShimmerWidget(width: double.infinity, height: 50);
          }

          if (state is DataTableLoadedState<BrandModel>) {
            return TypeAheadField<BrandModel>(
              builder: (context, ctr, focusNode) {
                return TextFormField(
                  focusNode: focusNode,
                  controller: productCubit.brandController,
                  decoration: const InputDecoration(
                    labelText: 'Select Brand',
                    suffixIcon: Icon(Iconsax.box),
                    border: OutlineInputBorder(),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                final searchTerm = pattern.toLowerCase();
                return state.data
                    .where(
                      (brand) => brand.name.toLowerCase().contains(searchTerm),
                    )
                    .toList();
              },
              itemBuilder:
                  (context, brand) => ListTile(title: Text(brand.name)),
              onSelected: (brand) => productCubit.triggerBrandSelection(brand),
            );
          }

          if (state is DataTableFailureState) {
            return Text(state.message);
          }

          return const SizedBox();
        },
      ),
    );
  }
}
