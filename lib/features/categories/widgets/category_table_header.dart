import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';

class CategoryTableHeader extends StatelessWidget {
  const CategoryTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return TableHeader(
      buttonText: 'Create New Category',
      onPressed:
          () => context.read<SidebarCubit>().screenOnTap(
            SidebarRoutes.createCategory,
          ),
      searchOnChanged:
          (quary) => context.read<CategoryCubit>().filterData(quary),
    );
  }
}
