import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/dashboard/screens/responsive_screen/dashboard_base.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/dashboard_card.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/order_status_pie_chart.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/recent_order_table.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/weekly_sales_graph.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardBase(
      content: Column(
        children: [
          _DashboardCards(),
          SizedBox(height: AppSizes.spaceBtwSections),
          WeeklySalesGraph(),
          SizedBox(height: AppSizes.spaceBtwSections),
          RecentOrdersTable(),
          SizedBox(height: AppSizes.spaceBtwSections),
          OrderStatusPieChart(),
          SizedBox(height: AppSizes.spaceBtwItems),
        ],
      ),
    );
  }
}

class _DashboardCards extends StatelessWidget {
  const _DashboardCards();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DashboardCard(title: 'Sales total', subtitle: '\$1200.6', stats: 25),
        SizedBox(height: AppSizes.spaceBtwItems),
        DashboardCard(
          title: 'Average Order Value',
          subtitle: '\$25',
          stats: 15,
        ),
        SizedBox(height: AppSizes.spaceBtwItems),
        DashboardCard(title: 'Total Orders', subtitle: '36', stats: 44),
        SizedBox(height: AppSizes.spaceBtwItems),
        DashboardCard(title: 'Visitors', subtitle: '25,035', stats: 2),
      ],
    );
  }
}
