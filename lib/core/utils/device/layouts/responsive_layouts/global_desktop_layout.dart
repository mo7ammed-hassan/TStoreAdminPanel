import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/headers/header.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_layouts/build_screen_body.dart';

class GlobalDesktopLayout extends StatelessWidget {
  const GlobalDesktopLayout({super.key, this.body});
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Expanded(child: Sidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // HEADER
                Header(),

                // BODY
                Expanded(child: BuildScreenBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
