import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/circular_image.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';

class UploaderImage<C extends Cubit<S>, S> extends StatelessWidget {
  const UploaderImage({
    super.key,
    this.circular = false,
    this.width = 100,
    this.height = 100,
    this.memoryImage,
    this.icon = Iconsax.edit_2,
    this.top,
    this.left = 0,
    this.right,
    this.bottom = 0,
    this.onImageChanged,
    this.fit = BoxFit.contain,
    required this.imageSelector,
    this.showUplaodIcon = true,
    this.padding = AppSizes.sm,
  });

  final bool circular;

  final double width;

  final double height;

  final Uint8List? memoryImage;

  final IconData icon;

  final double? top;

  final double? left;

  final double? right;

  final double? bottom;

  final BoxFit fit;

  final double padding;

  final bool showUplaodIcon;

  final VoidCallback? onImageChanged;
  final String? Function(S state) imageSelector;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return BlocSelector<C, S, String?>(
      selector: imageSelector,
      builder: (context, imageUrl) {
        final imageType = _getImageType(imageUrl);

        return showUplaodIcon
            ? Stack(
              children: [
                circular
                    ? CircularImage(
                      fit: fit,
                      image:
                          HelperFunctions.isEmpty(imageUrl)
                              ? AppImages.defaultImage
                              : imageUrl,
                      width: width,
                      height: height,
                      isNetworkImage: imageType == ImageType.network,
                      backgroundColor:
                          isDark
                              ? AppColors.darkGrey
                              : AppColors.primaryBackground,
                    )
                    : TRoundedImage(
                      fit: fit,
                      width: width,
                      height: height,
                      imageType: imageType,
                      memoryImage: memoryImage,
                      padding: padding ,
                      image:
                          HelperFunctions.isEmpty(imageUrl)
                              ? AppImages.defaultImage
                              : imageUrl,
                      backgroundColor:
                          isDark
                              ? AppColors.darkGrey
                              : AppColors.primaryBackground,
                    ),

                Positioned(
                  top: top,
                  left: left,
                  right: right,
                  bottom: bottom,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(icon, color: Colors.white),
                        onPressed: onImageChanged,
                        color: AppColors.white,
                        iconSize: AppSizes.md,
                      ),
                    ),
                  ),
                ),
              ],
            )
            : TRoundedImage(
              fit: fit,
              width: width,
              height: height,
              imageType: imageType,
              memoryImage: memoryImage,
              image:
                  HelperFunctions.isEmpty(imageUrl)
                      ? AppImages.defaultImage
                      : imageUrl,
              backgroundColor:
                  isDark ? AppColors.darkGrey : AppColors.primaryBackground,
            );
      },
    );
  }

  ImageType _getImageType(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty || imageUrl == '') {
      return ImageType.asset;
    }
    return imageUrl.startsWith('http') ? ImageType.network : ImageType.memory;
  }
}
