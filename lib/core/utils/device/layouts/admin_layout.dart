import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/services/system_ui_service.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_layouts/global_desktop_layout.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_layouts/global_mobile_layout.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_layouts/global_tablet_layout.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/main_global_responsive_layout.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});
  @override
  Widget build(BuildContext context) {
    SystemUiService.setSystemUIOverlayStyle(context);
    return BlocProvider(
      create: (context) => getIt<SidebarCubit>(),
      child: const SafeArea(
        child: Scaffold(
          body: MainGlobalResponsiveLayout(
            globalMobileLayout: GlobalMobileLayout(),
            globalTabletLayout: GlobalTabletLayout(),
            globalDesktopLayout: GlobalDesktopLayout(),
          ),
        ),
      ),
    );
  }
}
