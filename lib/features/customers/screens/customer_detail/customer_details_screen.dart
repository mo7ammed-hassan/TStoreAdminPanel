import 'package:flutter/widgets.dart';
import 'package:t_store_admin_panel/features/customers/screens/customer_detail/responsive_screens/customer_details_desktop_screen.dart';
import 'package:t_store_admin_panel/features/customers/screens/customer_detail/responsive_screens/customer_details_mobile_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  /// final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    // final customer =
    //     ModalRoute.of(context)!.settings.arguments as CustomerModel;
    return const ResponsiveScreens(
      desktop: CustomerDetailsDesktopScreen(),
      mobile: CustomerDetailsMobileScreen(),
    );
  }
}
