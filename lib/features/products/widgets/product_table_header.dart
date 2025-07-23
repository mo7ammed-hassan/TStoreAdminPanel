import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/features/products/cubits/product/product_cubit.dart';

class ProductTableHeader extends StatelessWidget {
  const ProductTableHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return TableHeader(
      buttonText: 'Add Product',
      onPressed:
          () => context.read<SidebarCubit>().screenOnTap(
            SidebarRoutes.createProduct,
          ),
      searchOnChanged:
          (query) => context.read<ProductCubit>().searchQuary(query),
    );
  }
}
