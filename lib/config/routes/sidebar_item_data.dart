import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/features/authentiacation/screens/login/login_screen.dart';
import 'package:t_store_admin_panel/features/banners/screens/all_banners/banner_screen.dart';
import 'package:t_store_admin_panel/features/banners/screens/create_banners/create_banner_screen.dart';
import 'package:t_store_admin_panel/features/banners/screens/edit_banners/edit_banner_screen.dart';
import 'package:t_store_admin_panel/features/brands/screens/all_brands/brand_screen.dart';
import 'package:t_store_admin_panel/features/brands/screens/create_brands/create_brand_screen.dart';
import 'package:t_store_admin_panel/features/brands/screens/edit_brands/edit_brand_screen.dart';
import 'package:t_store_admin_panel/features/categories/screens/all_categories/category_screen.dart';
import 'package:t_store_admin_panel/features/categories/screens/create_category/create_category_screen.dart';
import 'package:t_store_admin_panel/features/categories/screens/edit_category/edit_category_screen.dart';
import 'package:t_store_admin_panel/features/customers/screens/all_customers/customers_screen.dart';
import 'package:t_store_admin_panel/features/customers/screens/customer_detail/customer_details_screen.dart';
import 'package:t_store_admin_panel/features/dashboard/screens/dashboard_screen.dart';
import 'package:t_store_admin_panel/features/media/screens/media_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/orders_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/order_detail/order_details_screen.dart';
import 'package:t_store_admin_panel/features/personalization/profile/profile_screen.dart';
import 'package:t_store_admin_panel/features/personalization/settings/settings_screen.dart';
import 'package:t_store_admin_panel/features/products/screens/all_products/product_screen.dart';
import 'package:t_store_admin_panel/features/products/screens/create_product/create_product_screen.dart';
import 'package:t_store_admin_panel/features/products/screens/edit_product/edit_product_screen.dart';

class SidebarItemData {
  final SidebarRoutes route;
  final String path;
  final Widget? screen;
  final Widget Function(dynamic args)? screenWithArgs;

  const SidebarItemData({
    required this.route,
    required this.path,
    this.screen,
    this.screenWithArgs,
  });
}

final Map<SidebarRoutes, SidebarItemData> sidebarItems = {
  SidebarRoutes.dashboard: const SidebarItemData(
    route: SidebarRoutes.dashboard,
    path: Routes.dashboard,
    screen: DashboardScreen(),
  ),
  SidebarRoutes.media: const SidebarItemData(
    route: SidebarRoutes.media,
    path: Routes.media,
    screen: MediaScreen(),
  ),
  SidebarRoutes.categories: const SidebarItemData(
    route: SidebarRoutes.categories,
    path: Routes.categories,
    screen: CategoryScreen(),
  ),
  SidebarRoutes.createCategory: const SidebarItemData(
    route: SidebarRoutes.createCategory,
    path: Routes.createCategory,
    screen: CreateCategoryScreen(),
  ),
  SidebarRoutes.editCategory: SidebarItemData(
    route: SidebarRoutes.editCategory,
    path: Routes.editCategory,
    screenWithArgs:
        (args) => EditCategoryScreen(category: args as CategoryModel),
  ),
  SidebarRoutes.brands: const SidebarItemData(
    route: SidebarRoutes.brands,
    path: Routes.brands,
    screen: BrandScreen(),
  ),
  SidebarRoutes.createBrand: const SidebarItemData(
    route: SidebarRoutes.createBrand,
    path: Routes.createBrand,
    screen: CreateBrandScreen(),
  ),
  SidebarRoutes.editBrand: SidebarItemData(
    route: SidebarRoutes.editBrand,
    path: Routes.editBrand,
    screenWithArgs: (args) => EditBrandScreen(brandModel: args as BrandModel),
  ),
  SidebarRoutes.products: const SidebarItemData(
    route: SidebarRoutes.products,
    path: Routes.products,
    screen: ProductScreen(),
  ),
  SidebarRoutes.createProduct: const SidebarItemData(
    route: SidebarRoutes.createProduct,
    path: Routes.createProduct,
    screen: CreateProductScreen(),
  ),
  SidebarRoutes.editProduct: SidebarItemData(
    route: SidebarRoutes.editProduct,
    path: Routes.editProduct,
    screenWithArgs:
        (args) => EditProductScreen(productModel: args as ProductModel),
  ),
  SidebarRoutes.banners: const SidebarItemData(
    route: SidebarRoutes.banners,
    path: Routes.banners,
    screen: BannerScreen(),
  ),
  SidebarRoutes.createBanner: const SidebarItemData(
    route: SidebarRoutes.createBanner,
    path: Routes.createBanner,
    screen: CreateBannerScreen(),
  ),
  SidebarRoutes.editBanner: SidebarItemData(
    route: SidebarRoutes.editBanner,
    path: Routes.editBanner,
    screenWithArgs: (args) => EditBannerScreen(banner: args as BannerModel),
  ),
  SidebarRoutes.orders: const SidebarItemData(
    route: SidebarRoutes.orders,
    path: Routes.orders,
    screen: OrdersScreen(),
  ),
  SidebarRoutes.orderDetails: SidebarItemData(
    route: SidebarRoutes.orderDetails,
    path: Routes.orderDetail,
    screenWithArgs: (args) => OrderDetailsScreen(order: args as OrderModel),
  ),
  SidebarRoutes.settings: const SidebarItemData(
    route: SidebarRoutes.settings,
    path: Routes.settings,
    screen: SettingsScreen(),
  ),
  SidebarRoutes.profile: const SidebarItemData(
    route: SidebarRoutes.profile,
    path: Routes.profile,
    screen: ProfileScreen(),
  ),
  SidebarRoutes.customers: const SidebarItemData(
    route: SidebarRoutes.customers,
    path: Routes.customers,
    screen: CustomersScreen(),
  ),
  SidebarRoutes.customerDetails: SidebarItemData(
    route: SidebarRoutes.customerDetails,
    path: Routes.customerDetails,
    screenWithArgs: (args) => const CustomerDetailScreen(),
  ),
  SidebarRoutes.logout: const SidebarItemData(
    route: SidebarRoutes.logout,
    path: Routes.login,
    screen: LoginScreen(),
  ),
};
