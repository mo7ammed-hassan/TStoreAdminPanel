import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_attributes/product_attributes.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_brands.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_categories.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_images.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_stok_and_price/product_stock_and_price.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_thumbnail_image.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_title_and_description.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_type_widget.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_variations/product_variations.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/widgets/product_visibility_widget.dart';
import 'package:t_store_admin_panel/features/products/widgets/product_bottom_navigation_buttons.dart';

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(
        cubit: context.read<CreateProductCubit>(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              const BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbs: [Routes.products, 'Create Product'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              const ProductTitleAndDescription(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // stock and price
              RoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stock & Price',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // product type
                    const ProductTypeWidget(),
                    const SizedBox(height: AppSizes.spaceBtwInputFields),

                    // Stock
                    const ProductStockAndPricing(),
                    const SizedBox(height: AppSizes.spaceBtwSections),

                    // Attributes
                    const ProductAttributes(),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              const ProductVariations(),

              const SizedBox(height: AppSizes.defaultSpace),

              const ProductThumbnailImage(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Product Images
              const ProductImages(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Product Brands
              const ProductBrands(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Product Categories
              const ProductCategories(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Product Visibility
              const ProductVisibilityWidget(),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
