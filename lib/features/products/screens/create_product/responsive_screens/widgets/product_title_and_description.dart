import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/validators/validation.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();
    return RoundedContainer(
      child: Form(
        key: cubit.basicInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            TextFormField(
              validator:
                  (value) =>
                      ValidatorFields.validateEmptyText('Product Title', value),
              controller: cubit.productTitleController,
              decoration: const InputDecoration(labelText: 'Product Title'),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            SizedBox(
              height: DeviceUtilities.isMobileScreen(context) ? 200 : 300,
              child: TextFormField(
                expands: true,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator:
                    (value) => ValidatorFields.validateEmptyText(
                      'Product Description',
                      value,
                    ),
                controller: cubit.productDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  hintText: 'Add your product description here...',
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
