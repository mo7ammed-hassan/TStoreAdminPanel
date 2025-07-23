import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_additional_images.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProductCubit>();
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Product Images',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Images
          BlocSelector<CreateProductCubit, CreateProductStates, List<String>>(
            selector: (state) {
              return state.additionalImages ?? [];
            },
            builder: (context, state) {
              return ProductAdditionalImages(
                additionalProductImagesUrls: state,
                onTapAddImages: cubit.selectAdditionalImage,
                onTapRemoveImage:
                    (index) => cubit.removeImage(index, state[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
