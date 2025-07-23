import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_stok_and_price/product_stok_and_price_larg_screen.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_stok_and_price/product_stok_and_price_mobile_app.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final productType = context.select(
      (CreateProductCubit cubit) => cubit.state.productType,
    );

    if (productType != ProductType.single) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Form(
          key: context.read<CreateProductCubit>().stockAndPriceFormKey,
          child:
              DeviceUtilities.isMobileScreen(context)
                  ? const ProductStockAndPricingMobile()
                  : const ProductStockAndPricingLargScreen(),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        
        Divider(
          color: isDark ? AppColors.darkerGrey : AppColors.primaryBackground,
        ),
      ],
    );
  }
}
