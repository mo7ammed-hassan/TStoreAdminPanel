import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            'Product Type',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        const Expanded(flex: 2, child: _ProductTypeRadioButtons()),
      ],
    );
  }
}

class _ProductTypeRadioButtons extends StatelessWidget {
  const _ProductTypeRadioButtons();

  @override
  Widget build(BuildContext context) {
    final productType = context.select(
      (CreateProductCubit cubit) => cubit.state.productType,
    );
    final cubit = context.read<CreateProductCubit>();

    return Row(
      children: [
        _RadioButton(
          value: ProductType.single,
          label: 'Single',
          selected: productType == ProductType.single,
          onChanged: () => cubit.changeProductType(ProductType.single),
        ),
        _RadioButton(
          value: ProductType.variable,
          label: 'Variable',
          selected: productType == ProductType.variable,
          onChanged: () => cubit.changeProductType(ProductType.variable),
        ),
      ],
    );
  }
}

class _RadioButton extends StatelessWidget {
  const _RadioButton({
    required this.value,
    required this.label,
    required this.selected,
    required this.onChanged,
  });

  final ProductType value;
  final String label;
  final bool selected;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedBox(
        child: RadioMenuButton(
          value: value,
          groupValue: selected ? value : null,
          onChanged: (_) => onChanged(),
          child: Text(label),
        ),
      ),
    );
  }
}

// class ProductTypeWidget extends StatelessWidget {
//   const ProductTypeWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<CreateProductCubit>();
//     return Row(
//       children: [
//         Flexible(
//           child: Text(
//             'Product Type',
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ),
//         const SizedBox(width: AppSizes.spaceBtwItems),

//         BlocSelector<CreateProductCubit, CreateProductStates, ProductType>(
//           selector: (state) {
//             return state.productType ?? cubit.productType;
//           },
//           builder: (context, state) {
//             return Expanded(
//               flex: 2,
//               child: Row(
//                 children: [
//                   Flexible(
//                     child: FittedBox(
//                       child: RadioMenuButton(
//                         value: ProductType.single,
//                         groupValue: state,
//                         onChanged: (value) => cubit.toggleType(),
//                         child: const Text('Single'),
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     child: FittedBox(
//                       child: RadioMenuButton(
//                         value: ProductType.variable,
//                         groupValue: state,
//                         onChanged: (value) => cubit.toggleType(),
//                         child: const Text('Variable'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
