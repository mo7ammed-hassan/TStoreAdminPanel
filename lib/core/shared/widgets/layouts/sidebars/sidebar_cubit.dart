import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_states.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/extensions/sidebar_extension.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/features/authentiacation/cubits/user/cubit/user_cubit.dart';

class SidebarCubit extends Cubit<SidebarStates> {
  SidebarCubit() : super(SidebarInitial());

  SidebarRoutes activeItem = SidebarRoutes.dashboard;
  SidebarRoutes? hoverItem;
  SidebarRoutes? previousItem;

  final List<(SidebarRoutes route, dynamic arguments)> _history = [];

  void changeActiveItem(SidebarRoutes route) {
    if (activeItem != route) {
      _pushToHistory(activeItem);
      previousItem = activeItem;
      activeItem = route;
      emit(SidebarItemChanged(route));
    }
  }

  void changeHoverItem(SidebarRoutes? route) {
    if (route != null && hoverItem != route && !isActive(route)) {
      hoverItem = route;
      emit(SidebarHoverChanged(route));
    } else {
      hoverItem = null;
      emit(SidebarHoverChanged(null));
    }
  }

  void _pushToHistory(SidebarRoutes route, [dynamic arguments]) {
    _history.add((route, arguments));
  }

  bool isActive(SidebarRoutes route) => activeItem == route;
  bool isHovering(SidebarRoutes route) => hoverItem == route;

  void menuOnTap(BuildContext context, SidebarRoutes route) async {
    if (route == SidebarRoutes.logout) {
      await getIt<UserCubit>().logoutOnConfirmation();
      return;
    }
    if (!isActive(route)) {
      changeActiveItem(route);
      changeHoverItem(null);
      if (context.mounted &&
          (DeviceUtilities.isMobileScreen(context) || DeviceUtilities.isTabletScreen(context))) {
        context.popPage(context);
      }
    }
  }

  void screenOnTap(SidebarRoutes route, {Object? arguments}) {
    _pushToHistory(activeItem, arguments);
    previousItem = activeItem;
    emit(SidebarSubRouteNavigated(route, arguments));
  }

  /// Navigates back to the previous screen from history if available.
  /// Returns `true` if navigation happened, `false` otherwise.
  bool onBackPressed() {
    if (_history.isNotEmpty) {
      final (route, args) = _history.removeLast();
      activeItem = route;
      if (args != null) {
        emit(SidebarSubRouteNavigated(route, args));
      } else {
        emit(SidebarItemChanged(route));
      }
      return true;
    }
    return false;
  }

  Widget? getCurrentScreen() => activeItem.screen;

  Widget? getCurrentScreenWithArguments(dynamic arguments) =>
      activeItem.screenWithArguments(arguments);

  SidebarRoutes extractScreenRoute(SidebarStates state) {
    return switch (state) {
      SidebarSubRouteNavigated(:final route) => route,
      SidebarItemChanged(:final route) => route,
      _ => activeItem,
    };
  }

  void changeToDashboard() {
    changeActiveItem(SidebarRoutes.dashboard);
    changeHoverItem(null);
  }
}
