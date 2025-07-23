import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/features/brands/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/screens/create_brands/cubits/create_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/screens/create_brands/responsive_screens/create_brand_desktop_screen.dart';
import 'package:t_store_admin_panel/features/brands/screens/create_brands/responsive_screens/create_brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/brands/screens/create_brands/responsive_screens/create_brand_tablet_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandCubit = getIt<BrandCubit>();
    return BlocProvider(
      create: (context) => getIt<CreateBrandCubit>(),
      child: ResponsiveScreens(
        desktop: CreateBrandDesktopScreen(brandCubit: brandCubit),
        tablet: CreateBrandTabletScreen(brandCubit: brandCubit),
        mobile: CreateBrandMobileScreen(brandCubit: brandCubit),
      ),
    );
  }
}
