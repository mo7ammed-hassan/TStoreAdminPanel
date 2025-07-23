import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/dashboard/screens/responsive_screen/dashboard_base.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/dashboard_card.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/order_status_pie_chart.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/weekly_sales_graph.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/recent_order_table.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

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
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Sales total',
                subtitle: '\$1200.6',
                stats: 25,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(
              child: DashboardCard(
                title: 'Average Order Value',
                subtitle: '\$25',
                stats: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Total Orders',
                subtitle: '36',
                stats: 44,
              ),
            ),
            SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(
              child: DashboardCard(
                title: 'Visitors',
                subtitle: '25,035',
                stats: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
