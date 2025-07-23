import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/features/customers/cubits/customer_cubit.dart';
import 'package:t_store_admin_panel/features/customers/screens/all_customers/responsive_screens/customers_desktop_screen.dart';
import 'package:t_store_admin_panel/features/customers/screens/all_customers/responsive_screens/customers_mobile_screen.dart';
import 'package:t_store_admin_panel/features/customers/screens/all_customers/responsive_screens/custromer_tablet_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomerCubit>(),
      child: const ResponsiveScreens(
        desktop: CustomersDesktopScreen(),
        tablet: CustromerTabletScreen(),
        mobile: CustomersMobileScreen(),
      ),
    );
  }
}
