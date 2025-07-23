import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';

import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoryCubit>(),
      child: BlocSelector<
        CreateProductCubit,
        CreateProductStates,
        List<CategoryModel>
      >(
        selector: (state) => state.categories ?? [],
        builder: (context, selectedCategories) {
          return RoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                BlocBuilder<CategoryCubit, BaseDataTableStates>(
                  builder: (context, state) {
                    if (state is DataTableLoadingState) {
                      return const ShimmerWidget(
                        width: double.infinity,
                        height: 50,
                      );
                    }
                    if (state is DataTableLoadedState<CategoryModel>) {
                      return _buildMultiSelect(
                        context,
                        state.data, // from category cubit
                        selectedCategories,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMultiSelect(
    BuildContext context,
    List<CategoryModel> categories,
    List<CategoryModel> selectedCategories,
  ) {
    final productCubit = context.read<CreateProductCubit>();

    return MultiSelectDialogField<CategoryModel>(
      buttonText: const Text('Select Categories'),
      title: const Text('Categories'),
      items:
          categories
              .map((category) => MultiSelectItem(category, category.name))
              .toList(),
      listType: MultiSelectListType.CHIP,
      initialValue: selectedCategories,
      onConfirm: (values) => productCubit.triggerCategorySelection(values),
    );
  }
}
