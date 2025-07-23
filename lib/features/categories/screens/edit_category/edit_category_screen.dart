import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/edit_category/edit_category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/screens/edit_category/responsive_screens/edit_category_desktop_screen.dart';
import 'package:t_store_admin_panel/features/categories/screens/edit_category/responsive_screens/edit_category_mobile_screen.dart';
import 'package:t_store_admin_panel/features/categories/screens/edit_category/responsive_screens/edit_category_tablet_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final categoryCubit = getIt<CategoryCubit>();

    return BlocProvider(
      create: (context) => getIt<EditCategoryCubit>()..initData(category),
      child: ResponsiveScreens(
        desktop: EditCategoryDesktopScreen(
          category: category,
          categoryCubit: categoryCubit,
        ),
        tablet: EditCategoryTabletScreen(
          category: category,
          categoryCubit: categoryCubit,
        ),
        mobile: EditCategoryMobileScreen(
          category: category,
          categoryCubit: categoryCubit,
        ),
      ),
    );
  }
}
