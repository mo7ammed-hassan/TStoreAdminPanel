import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/checkbox/toggle_checkbox_menu_button.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/validators/validation.dart';
import 'package:t_store_admin_panel/features/brands/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/screens/create_brands/cubits/create_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/screens/create_brands/cubits/create_brand_states.dart';
import 'package:t_store_admin_panel/features/brands/screens/create_brands/responsive_screens/widgets/categories_section.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key, required this.brandCubit});
  final BrandCubit brandCubit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateBrandCubit>();
    return RoundedContainer(
      width: DeviceUtilities.isMobileScreen(context) ? double.infinity : 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: BlocListener<CreateBrandCubit, CreateBrandStates>(
        listener: (context, state) {
          if (state is CreateBrandSuccessState) {
            brandCubit.addNewItem(state.brand);
            cubit.resetForm();
          }
        },
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(height: AppSizes.sm),

              Text(
                'Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              TextFormField(
                controller: cubit.brandNameController,
                validator:
                    (value) => ValidatorFields.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                  labelText: 'Brand Name',
                  prefixIcon: Icon(Iconsax.box),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields / 2),

              const CategoriesSection(),

              const SizedBox(height: AppSizes.spaceBtwInputFields),

              UploaderImage<CreateBrandCubit, CreateBrandStates>(
                imageSelector:
                    (state) =>
                        state is PickImageState
                            ? state.imageUrl
                            : cubit.imageUrl,
                width: 80,
                height: 80,
                onImageChanged: cubit.pickImage,
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields),

              ToggleCheckboxMenuButton<CreateBrandCubit, CreateBrandStates>(
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
                  onPressed: () => cubit.createBrand(),
                  child: const Text('Create'),
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
            ],
          ),
        ),
      ),
    );
  }
}
