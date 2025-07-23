import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';

class BrandTableHeader extends StatelessWidget {
  const BrandTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return TableHeader(
      buttonText: 'Create New Brand',
      onPressed:
          () => context.read<SidebarCubit>().screenOnTap(
            SidebarRoutes.createBrand,
          ),
      searchOnChanged: (query) => context.read<BannerCubit>().filterData(query),
    );
  }
}
