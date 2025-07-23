import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Radio buttons for visibility options
          BlocSelector<CreateProductCubit, CreateProductStates, bool>(
            selector: (state) {
              return state.isFeatured;
            },
            builder: (context, state) {
              final groupValue =
                  state
                      ? ProductVisibility.pubblished
                      : ProductVisibility.hidden;

              return Column(
                children: [
                  _buildVisibilityRadioButton(
                    ProductVisibility.pubblished,
                    'Published',
                    cubit,
                    groupValue: groupValue,
                  ),
                  _buildVisibilityRadioButton(
                    ProductVisibility.hidden,
                    'Hidden',
                    cubit,
                    groupValue: groupValue,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityRadioButton(
    ProductVisibility value,
    String label,
    CreateProductCubit cubit, {
    required ProductVisibility groupValue,
  }) {
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: groupValue,
      onChanged: (value) => cubit.changeProductVisibility(value!),
      child: Text(label),
    );
  }
}
