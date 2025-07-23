import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/cubits/create_banner/create_banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/screens/create_banners/responsive_screens/create_banner_desktop_screen.dart';
import 'package:t_store_admin_panel/features/banners/screens/create_banners/responsive_screens/create_brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/banners/screens/create_banners/responsive_screens/create_banner_tablet_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerCubit = getIt<BannerCubit>();
    return BlocProvider(
      create: (context) => getIt<CreateBannerCubit>(),
      child: ResponsiveScreens(
        desktop: CreateBannerDesktopScreen(bannerCubit: bannerCubit),
        tablet: CreateBannerTabletScreen(bannerCubit: bannerCubit),
        mobile: CreateBannerMobileScreen(bannerCubit: bannerCubit),
      ),
    );
  }
}
