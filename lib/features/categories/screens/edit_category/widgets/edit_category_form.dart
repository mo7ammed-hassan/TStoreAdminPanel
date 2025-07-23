import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/checkbox/toggle_checkbox_menu_button.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/validators/validation.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/categories/cubits/edit_category/edit_category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/edit_category/edit_category_state.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, this.category});
  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditCategoryCubit>();
    return RoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: AppSizes.sm),

            Text(
              'Edit Category',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            TextFormField(
              validator:
                  (value) => ValidatorFields.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Iconsax.category),
              ),
              controller: cubit.nameController,
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            BlocBuilder<EditCategoryCubit, EditCategoryState>(
              buildWhen:
                  (previous, current) =>
                      current is SelectedParentState ||
                      current is FetchCategoriesState,
              builder: (context, state) {
                return DropdownButtonFormField<CategoryModel>(
                  decoration: const InputDecoration(
                    labelText: 'Parent Category',
                    hintText: 'Parent Category',
                    prefixIcon: Icon(Iconsax.bezier),
                  ),
                  onChanged: (value) => cubit.selectedParent = value!,
                  items:
                      cubit.categories
                          .map(
                            (item) => DropdownMenuItem<CategoryModel>(
                              value: item,
                              child: Row(children: [Text(item.name)]),
                            ),
                          )
                          .toList(),
                  value:
                      cubit.selectedParent.id!.isNotEmpty
                          ? cubit.selectedParent
                          : null,
                );
              },
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            UploaderImage<EditCategoryCubit, EditCategoryState>(
              width: 80,
              height: 80,
              imageSelector:
                  (state) =>
                      state is PickImageState ? state.imageUrl : cubit.imageUrl,
              onImageChanged: cubit.pickImage,
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields),

            ToggleCheckboxMenuButton<EditCategoryCubit, EditCategoryState>(
              selector:
                  (state) =>
                      state is ToggleFeatured
                          ? state.isFeatured
                          : cubit.isFeatured,
              onChanged: (value) => cubit.toggleIsFeatured(value),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => cubit.updateCategory(category!),
                child: const Text('Update'),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
