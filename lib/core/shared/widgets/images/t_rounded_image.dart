import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';

class TRoundedImage extends StatelessWidget {
  final String? image;
  final bool applyImageRaduis;
  final BoxBorder? border;
  final double borderRadius;
  final BoxFit? fit;
  final File? file;
  final ImageType imageType;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Uint8List? memoryImage;
  final double width, height, padding;
  final double? margin;
  final bool showImageRaduis;

  const TRoundedImage({
    super.key,
    this.image,
    this.applyImageRaduis = true,
    this.border,
    this.borderRadius = AppSizes.md,
    this.fit = BoxFit.contain,
    this.file,
    required this.imageType,
    this.overlayColor,
    this.backgroundColor,
    this.memoryImage,
    this.width = 56,
    this.height = 56,
    this.padding = AppSizes.sm,
    this.margin,
    this.showImageRaduis = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return ClipRRect(
      child: Container(
        width: width,
        height: height,
        margin: margin != null ? EdgeInsets.all(margin!) : null,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: border,
          color:
              backgroundColor ??
              (isDark ? AppColors.darkerGrey : AppColors.primaryBackground),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: FittedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              showImageRaduis ? borderRadius * 3 : 0,
            ),
            child: _buildImageWidget(isDark),
          ),
        ),
      ),
    );
  }

  ClipRRect _buildImageWidget(bool isDark) {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
      case ImageType.file:
        imageWidget = _buildFileImage();
      case ImageType.asset:
        imageWidget = _buildAssetImage(isDark);
        break;
    }

    return ClipRRect(
      borderRadius:
          applyImageRaduis
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
      child: imageWidget,
    );
  }

  Widget _buildNetworkImage() {
    if (image != null && image!.isNotEmpty) {
      // Use cached network image for efficient loading and cache image // Not working for web but just for loading
      return CachedNetworkImage(
        imageUrl: image!,
        fit: fit,
        width: width,
        height: height,
        color: overlayColor,
        progressIndicatorBuilder:
            (context, url, progress) => ShimmerWidget(
              height: height,
              width: width,
              //padding: EdgeInsets.all(padding),
            ),
        errorWidget: (context, url, error) => const Icon(Iconsax.image),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      // Display image from memory
      return Image(
        fit: fit,
        image: MemoryImage(memoryImage!),
        width: width,
        height: height,
        color: overlayColor,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildFileImage() {
    if (file != null) {
      // Display image from file
      return Image(
        fit: fit,
        image: FileImage(file!),
        color: overlayColor,
        width: width,
        height: height,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildAssetImage(bool isDark) {
    if (image != null && image!.isNotEmpty) {
      // Display image from asset
      return Image(fit: fit, image: AssetImage(image!), color: overlayColor);
    } else {
      return const SizedBox.shrink();
    }
  }
}
