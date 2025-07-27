import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_states.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    this.onTapAddImages,
    required this.additionalProductImagesUrls,
    this.onTapRemoveImage,
  });

  final Function()? onTapAddImages;
  final List<String> additionalProductImagesUrls;
  final void Function(int index)? onTapRemoveImage;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final hasImages = additionalProductImagesUrls.isNotEmpty;

    return SizedBox(
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main image upload area
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTapAddImages,
              behavior: HitTestBehavior.opaque,
              child: _buildMainUploadArea(),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Thumbnail list and add button
          SizedBox(
            height: 80,
            child: Row(
              children: [
                // Images list
                Expanded(
                  flex: 2,
                  child:
                      hasImages
                          ? _buildImageThumbnails()
                          : _buildPlaceholderThumbnails(isDark),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems / 2),

                // Add button
                _buildAddButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainUploadArea() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.defaultImages, width: 80, height: 80),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const Text('Add Additional Product Images'),
        ],
      ),
    );
  }

  Widget _buildImageThumbnails() {
    return ListView.separated(
      key: Key(additionalProductImagesUrls.join()),
      scrollDirection: Axis.horizontal,
      itemCount: additionalProductImagesUrls.length,
      separatorBuilder:
          (_, _) => const SizedBox(width: AppSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        return _buildThumbnailItem(index);
      },
    );
  }

  Widget _buildThumbnailItem(int index) {
    final image = additionalProductImagesUrls[index];
    return UploaderImage<CreateProductCubit, CreateProductStates>(
      width: 80,
      height: 80,
      top: 0,
      right: 0,
      left: null,
      bottom: null,
      imageSelector: (state) => image,
      icon: Iconsax.trash,
      onImageChanged: () => onTapRemoveImage!(index),
    );
  }

  Widget _buildPlaceholderThumbnails(bool isDark) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder:
          (_, _) => const SizedBox(width: AppSizes.spaceBtwItems / 2),
      itemBuilder:
          (_, _) => RoundedContainer(
            width: 80,
            height: 80,
            backgroundColor:
                isDark ? AppColors.darkGrey : AppColors.primaryBackground,
          ),
    );
  }

  Widget _buildAddButton() {
    return RoundedContainer(
      height: 80,
      width: 80,
      showBorder: true,
      borderColor: AppColors.grey,
      onTap: onTapAddImages,
      child: const Center(child: Icon(Iconsax.add)),
    );
  }
}
