import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/create_product_desktop_screen.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/responsive_screens/create_product_mobile_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';
import 'package:t_store_admin_panel/features/products/screens/product_listener_wrapper.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => getIt<CreateProductCubit>()..resetAllSelectedImages(),
      child: const ProductListenerWrapper(
        child: ResponsiveScreens(
          desktop: CreateProductDesktopScreen(),
          mobile: CreateProductMobileScreen(),
        ),
      ),
    );
  }
}
