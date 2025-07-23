import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/chip/choice_chip.dart';
import 'package:t_store_admin_panel/core/shared/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/brands/screens/edit_brands/cubit/edit_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/screens/edit_brands/cubit/edit_brand_states.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';

class EditCategoriesSection extends StatelessWidget {
  const EditCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final editBrandCubit = context.read<EditBrandCubit>();

    return BlocProvider(
      create: (context) => getIt<CategoryCubit>(),
      child: BlocBuilder<CategoryCubit, BaseDataTableStates>(
        builder: (context, state) {
          if (state is DataTableLoadingState) {
            return const ShimmerWidget(width: double.infinity, height: 50);
          }

          if (state is DataTableLoadedState<CategoryModel>) {
            return _buildCategoryChips(state.data, editBrandCubit);
          }

          if (state is DataTableFailureState) {
            return const Center(child: Text('Error loading categories'));
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildCategoryChips(
    List<CategoryModel> categories,
    EditBrandCubit brandCubit,
  ) {
    return BlocBuilder<EditBrandCubit, EditBrandStates>(
      buildWhen: (previous, current) => current is ToggleCategorySelectionState,
      builder: (context, brandState) {
        return Wrap(
          spacing: AppSizes.sm,
          children:
              categories.map((category) {
                final isSelected = brandCubit.selectedCategories.contains(
                  category,
                );

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.sm),
                  child: TChoiceChip(
                    text: category.name,
                    isSelected: isSelected,
                    onSelected:
                        (_) => brandCubit.toggleSelectedCategory(category),
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}
