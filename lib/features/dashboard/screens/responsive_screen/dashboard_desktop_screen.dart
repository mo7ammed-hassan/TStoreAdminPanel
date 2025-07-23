import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/dashboard/screens/responsive_screen/dashboard_base.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/dashboard_cards_row.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/order_status_pie_chart.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/recent_order_table.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/weekly_sales_graph.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardBase(
      content: Column(
        children: [
          DashboardCardsRow(),
          SizedBox(height: AppSizes.spaceBtwSections),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    WeeklySalesGraph(),
                    SizedBox(height: AppSizes.spaceBtwItems),
                    RecentOrdersTable(),
                  ],
                ),
              ),
              SizedBox(width: AppSizes.spaceBtwSections),
              Expanded(child: OrderStatusPieChart()),
              SizedBox(height: AppSizes.spaceBtwItems),
            ],
          ),
        ],
      ),
    );
  }
}