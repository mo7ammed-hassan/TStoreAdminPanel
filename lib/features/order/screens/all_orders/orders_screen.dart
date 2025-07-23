import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/features/order/cubits/order_cubit.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/responsive_screens/orders_desktop_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/responsive_screens/orders_mobile_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/responsive_screens/orders_tablet_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrderCubit>(),
      child: const ResponsiveScreens(
        desktop: OrdersDesktopScreen(),
        tablet: OrdersTabletScreen(),
        mobile: OrdersMobileScreen(),
      ),
    );
  }
}
