import 'package:flutter/widgets.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/features/order/screens/order_detail/responsive_screens/order_details_desktop_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/order_detail/responsive_screens/order_details_mobile_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreens(
      desktop: OrderDetailsDesktopScreen(order: order),
      mobile: OrderDetailsMobileScreen(order: order),
    );
  }
}
