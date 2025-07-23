import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_attributes/attribute_form.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_attributes/attributes_list.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_attributes/variation_button.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const _ConditionalDivider(),
        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        const AttributeForm(),
        const SizedBox(height: AppSizes.spaceBtwSections),

        Text(
          'All Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        RoundedContainer(
          backgroundColor:
              isDark ? AppColors.darkerGrey : AppColors.primaryBackground,
          padding: const EdgeInsets.all(12.0),
          child: const AttributesList(),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        const VariationGeneratorButton(),
      ],
    );
  }
}
