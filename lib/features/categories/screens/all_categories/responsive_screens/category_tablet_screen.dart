import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/categories/screens/all_categories/table/data_table.dart';
import 'package:t_store_admin_panel/features/categories/widgets/category_table_header.dart';

class CategoryTabletScreen extends StatelessWidget {
  const CategoryTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              BreadcrumbWithHeading(
                heading: 'Categories',
                breadcrumbs: ['Categories'],
              ),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Table Body
              RoundedContainer(
                child: Column(
                  children: [
                    CategoryTableHeader(),

                    SizedBox(height: AppSizes.spaceBtwItems),

                    // table
                    CategoryDataTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
