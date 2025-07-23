import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/features/products/cubits/create_product/create_product_cubit.dart';
import 'package:t_store_admin_panel/features/products/screens/edit_product/responsive_screens/edit_product_desktop_screen.dart';
import 'package:t_store_admin_panel/features/products/screens/edit_product/responsive_screens/edit_product_mobile_screen.dart';
import 'package:t_store_admin_panel/core/utils/device/layouts/responsive_screens.dart';
import 'package:t_store_admin_panel/features/products/screens/product_listener_wrapper.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateProductCubit>()..init(productModel),
      child: const ProductListenerWrapper(
        child: ResponsiveScreens(
          desktop: EditProductDesktopScreen(),
          mobile: EditProductMobileScreen(),
        ),
      ),
    );
  }
}
