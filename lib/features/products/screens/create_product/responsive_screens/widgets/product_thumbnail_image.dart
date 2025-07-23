import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final cubit = context.read<CreateProductCubit>();
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: AppSizes.spaceBtwItems),
          RoundedContainer(
            height: 300,
            backgroundColor:
                isDark ? AppColors.darkerGrey : AppColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: _BuildThumbnailImage(cubit: cubit)),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  // Add Thumbnail Button
                  _buildAddThumbnailButton(cubit),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      'Product Thumbnail',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  SizedBox _buildAddThumbnailButton(CreateProductCubit cubit) {
    return SizedBox(
      width: 200,
      child: OutlinedButton(
        onPressed: cubit.selectThumbnailImage,
        child: const Text('Add Thumbnail'),
      ),
    );
  }
}

class _BuildThumbnailImage extends StatelessWidget {
  const _BuildThumbnailImage({required this.cubit});
  final CreateProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateProductCubit, CreateProductStates, String>(
      selector: (state) {
        return state.thumbnail ?? '';
      },
      builder: (context, thumbnail) {
        final hasImage = HelperFunctions.isNotEmpty(thumbnail);
        return TRoundedImage(
          showImageRaduis: true,
          imageType: hasImage ? ImageType.network : ImageType.asset,
          image: hasImage ? thumbnail : AppImages.defaultImage,
          padding: hasImage ? AppSizes.xs : AppSizes.defaultSpace,
          width: 200,
          height: 200,
        );
      },
    );
  }
}
