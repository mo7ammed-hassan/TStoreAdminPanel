import 'package:t_store_admin_panel/core/utils/constants/enums.dart';

sealed class SidebarStates {}

class SidebarInitial extends SidebarStates {}

class SidebarItemChanged extends SidebarStates {
  final SidebarRoutes route;
  SidebarItemChanged(this.route);
}

class SidebarSubRouteNavigated extends SidebarStates {
  final SidebarRoutes route;
  final dynamic arguments;
  SidebarSubRouteNavigated(this.route, this.arguments);
}

class SidebarHoverChanged extends SidebarStates {
  final SidebarRoutes? route;
  SidebarHoverChanged(this.route);
}
