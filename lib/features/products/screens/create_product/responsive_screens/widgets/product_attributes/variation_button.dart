import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';
import 'package:t_store_admin_panel/features/products/models/variation_button_data.dart';

class VariationGeneratorButton extends StatelessWidget {
  const VariationGeneratorButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();

    return BlocSelector<
      CreateProductCubit,
      CreateProductStates,
      VariationButtonData
    >(
      selector: (state) {
        return VariationButtonData(
          productType: state.productType ,
          variations: state.productVariations ?? [],
        );
      },
      builder: (context, data) {
        if (data.productType == ProductType.variable &&
            data.variations.isEmpty) {
          return Center(
            child: SizedBox(
              width: 200,
              child: FittedBox(
                child: ElevatedButton.icon(
                  onPressed: () => cubit.generateProductVariations(),
                  label: const Text('Generate Variations'),
                  icon: const Icon(Iconsax.activity),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
