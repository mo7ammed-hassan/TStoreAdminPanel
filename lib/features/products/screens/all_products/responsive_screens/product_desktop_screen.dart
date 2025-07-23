import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/products/cubits/product/product_cubit.dart';
import 'package:t_store_admin_panel/features/products/screens/all_products/table/data_table.dart';
import 'package:t_store_admin_panel/features/products/widgets/product_table_header.dart';

class ProductDesktopScreen extends StatelessWidget {
  const ProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCubit>(),
      child: const Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.spaceBtwItems),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BreadcrumbWithHeading(
                  heading: 'Products',
                  breadcrumbs: ['Products'],
                ),
                SizedBox(height: AppSizes.spaceBtwSections),

                RoundedContainer(
                  child: Column(
                    children: [
                      ProductTableHeader(),
                      SizedBox(height: AppSizes.spaceBtwItems),

                      ProductDataTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
