import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/product/product_attributes_model.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_attributes/attribute_item.dart';

class AttributesList extends StatelessWidget {
  const AttributesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      CreateProductCubit,
      CreateProductStates,
      List<ProductAttributesModel>
    >(
      selector:
          (state) =>
              state.productAttributes ??
              context.read<CreateProductCubit>().productAttributes,
      builder: (context, attributes) {
        if (attributes.isEmpty) {
          return const _EmptyAttributesList();
        }

        final isDark = HelperFunctions.isDarkMode(context);
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: attributes.length,
          separatorBuilder:
              (context, index) =>
                  const SizedBox(height: AppSizes.spaceBtwItems),
          itemBuilder:
              (context, index) => AttributeItem(
                attribute: attributes[index],
                index: index,
                isDark: isDark,
              ),
        );
      },
    );
  }
}

class _EmptyAttributesList extends StatelessWidget {
  const _EmptyAttributesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 130,
            height: 50,
            child: SvgPicture.asset(AppImages.colorImage),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        const Text('There are no attributes added yet.'),
      ],
    );
  }
}
