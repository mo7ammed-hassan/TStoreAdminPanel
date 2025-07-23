import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/validators/validation.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';

class AttributeForm extends StatelessWidget {
  const AttributeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();

    return Form(
      key: cubit.attributesFormKey,
      child:
          DeviceUtilities.isDesktopScreen(context)
              ? const _DesktopAttributeForm()
              : const _MobileAttributeForm(),
    );
  }
}

class _DesktopAttributeForm extends StatelessWidget {
  const _DesktopAttributeForm();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _AttributeNameField()),
        SizedBox(width: AppSizes.spaceBtwItems),
        Expanded(flex: 2, child: _AttributeValueField()),
        SizedBox(width: AppSizes.spaceBtwItems),
        _AddAttributeButton(),
      ],
    );
  }
}

class _MobileAttributeForm extends StatelessWidget {
  const _MobileAttributeForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _AttributeNameField(),
        SizedBox(height: AppSizes.spaceBtwItems),
        _AttributeValueField(),
        SizedBox(height: AppSizes.spaceBtwItems),
        _AddAttributeButton(),
      ],
    );
  }
}

class _AttributeNameField extends StatelessWidget {
  const _AttributeNameField();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();

    return TextFormField(
      validator:
          (value) => ValidatorFields.validateEmptyText('Attribute Name', value),
      controller: cubit.attributeNameController,
      decoration: const InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors, Sizes, Materials.',
        border: InputBorder.none,
      ),
    );
  }
}

class _AttributeValueField extends StatelessWidget {
  const _AttributeValueField();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();

    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator:
            (value) =>
                ValidatorFields.validateEmptyText('Attribute Value', value),
        controller: cubit.attributeValueController,
        decoration: const InputDecoration(
          labelText: 'Attribute Value',
          hintText: 'Add attributes separated by | Ex: Red | Blue | Green',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}

class _AddAttributeButton extends StatelessWidget {
  const _AddAttributeButton();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();

    return SizedBox(
      width: DeviceUtilities.isMobileScreen(context) ? 150 : 100,
      child: ElevatedButton.icon(
        onPressed: cubit.addProductAttribute,
        label: const Text('Add'),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.black,
          side: const BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }
}
