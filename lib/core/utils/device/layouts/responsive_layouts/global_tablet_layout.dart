import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/headers/header.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_layouts/build_screen_body.dart';

class GlobalTabletLayout extends StatelessWidget {
  const GlobalTabletLayout({super.key, this.body});
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const Sidebar(), // Built once per layout change
      appBar: Header(scaffoldKey: scaffoldKey), // Built once per layout change
      body: const BuildScreenBody(), // Only this part changes during navigation
    );
  }
}

