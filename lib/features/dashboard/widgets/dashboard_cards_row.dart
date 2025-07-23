import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/dashboard_card.dart';

class DashboardCardsRow extends StatelessWidget {
  const DashboardCardsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
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
        SizedBox(width: AppSizes.spaceBtwItems),
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
    );
  }
}