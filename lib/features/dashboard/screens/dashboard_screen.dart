import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/features/dashboard/cubits/dashboard_cubit.dart';
import 'package:t_store_admin_panel/features/dashboard/screens/responsive_screen/dashboard_desktop_screen.dart';
import 'package:t_store_admin_panel/features/dashboard/screens/responsive_screen/dashboard_mobile_screen.dart';
import 'package:t_store_admin_panel/features/dashboard/screens/responsive_screen/dashboard_tablet_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: const ResponsiveScreens(
        mobile: DashboardMobileScreen(),
        tablet: DashboardTabletScreen(),
        desktop: DashboardDesktopScreen(),
      ),
    );
  }
}
