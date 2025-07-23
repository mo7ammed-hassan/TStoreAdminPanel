import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/cubits/edit_banner/edit_banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/screens/edit_banners/responsive_screens/edit_banner_desktop_screen.dart';
import 'package:t_store_admin_panel/features/banners/screens/edit_banners/responsive_screens/edit_banner_mobile_screen.dart';
import 'package:t_store_admin_panel/features/banners/screens/edit_banners/responsive_screens/edit_banner_tablet_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key, required this.banner});
  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final bannerCubit = getIt<BannerCubit>();
    return BlocProvider(
      create: (context) => getIt<EditBannerCubit>()..init(banner),
      child: ResponsiveScreens(
        desktop: EditBannerDesktopScreen(
          banner: banner,
          bannerCubit: bannerCubit,
        ),
        tablet: EditBannerTabletScreen(
          banner: banner,
          bannerCubit: bannerCubit,
        ),
        mobile: EditBannerMobileScreen(
          banner: banner,
          bannerCubit: bannerCubit,
        ),
      ),
    );
  }
}
