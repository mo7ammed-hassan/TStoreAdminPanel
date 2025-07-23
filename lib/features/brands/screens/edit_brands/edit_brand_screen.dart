import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/features/brands/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/screens/edit_brands/cubit/edit_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/screens/edit_brands/responsive_screens/edit_brand_desktop_screen.dart';
import 'package:t_store_admin_panel/features/brands/screens/edit_brands/responsive_screens/edit_brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/brands/screens/edit_brands/responsive_screens/edit_brand_tablet_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key, required this.brandModel});
  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    final brandCubit = getIt<BrandCubit>();

    return BlocProvider(
      create: (context) => getIt<EditBrandCubit>()..initData(brandModel),
      child: ResponsiveScreens(
        desktop: EditBrandDesktopScreen(
          brandModel: brandModel,
          brandCubit: brandCubit,
        ),
        tablet: EditBrandTabletScreen(
          brandModel: brandModel,
          brandCubit: brandCubit,
        ),
        mobile: EditBrandMobileScreen(
          brandModel: brandModel,
          brandCubit: brandCubit,
        ),
      ),
    );
  }
}
