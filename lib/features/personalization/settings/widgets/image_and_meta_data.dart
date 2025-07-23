import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/circular_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class ImageAndMetaData extends StatelessWidget {
  const ImageAndMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RoundedContainer(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.lg,
        horizontal: AppSizes.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              children: [
                // UploaderImage(
                //   imageSelector: (state) => AppImages.user,
                //   right: 10,
                //   bottom: 20,
                //   width: 200,
                //   height: 200,
                //   circular: true,
                //   left: null,
                //   icon: Iconsax.camera,
                //   onImageChanged: () {},
                // ),
                CircularImage(
                  image: AppImages.user,
                  width: 200,
                  height: 200,
                  backgroundColor:
                      isDark ? AppColors.darkGrey : AppColors.primaryBackground,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                Text(
                  'T Store',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
