import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/sidebar_item_data.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';

extension SidebarRouteExtension on SidebarRoutes {
  SidebarItemData get data => sidebarItems[this]!;

  SidebarRoutes? get route => data.route;

  String get path => data.path;

  Widget? get screen => data.screen ?? const SizedBox();

  // return screen with arguments
  Widget? screenWithArguments(Object? args) {
    if (data.screenWithArgs != null) {
      return data.screenWithArgs!(args);
    } else {
      return screen ?? const SizedBox();
    }
  }
}
