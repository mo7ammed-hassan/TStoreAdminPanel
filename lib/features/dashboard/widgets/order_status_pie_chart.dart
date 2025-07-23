import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/circular_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/dashboard/cubits/dashboard_cubit.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, ordersStatsData) {
          final cubit = context.read<DashboardCubit>();
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Status',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              if (DeviceUtilities.isTabletScreen(context) ||
                  (context.width >= 1296 && context.width <= 1272)) // 1557
                _TabletLayout(
                  ordersStatsData: cubit.ordersStatsData,
                  cubit: cubit,
                )
              else
                _MobileLayout(
                  ordersStatsData: cubit.ordersStatsData,
                  cubit: cubit,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  final Map<OrderStatus, int> ordersStatsData;
  final DashboardCubit cubit;

  const _TabletLayout({required this.ordersStatsData, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 380,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 75,
                sections: _buildSections(ordersStatsData, context),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: _buildDataTable(ordersStatsData, cubit),
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwSections),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final Map<OrderStatus, int> ordersStatsData;
  final DashboardCubit cubit;

  const _MobileLayout({required this.ordersStatsData, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 380,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 75,
              sections: _buildSections(ordersStatsData, context),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: _buildDataTable(ordersStatsData, cubit),
          ),
        ),
      ],
    );
  }
}

List<PieChartSectionData> _buildSections(
  Map<OrderStatus, int> ordersStatsData,
  BuildContext context,
) {
  return ordersStatsData.entries.map((entry) {
    final status = entry.key;
    final count = entry.value;
    return PieChartSectionData(
      value: count.toDouble(),
      radius: DeviceUtilities.isDesktopScreen(context) ? 65 : 50,
      color: HelperFunctions.getOrderStatusColor(status),
      title: count.toString(),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }).toList();
}

DataTable _buildDataTable(
  Map<OrderStatus, int> ordersStatsData,
  DashboardCubit cubit,
) {
  return DataTable(
    columns: const [
      DataColumn(label: Text('Status')),
      DataColumn(label: Text('Orders')),
      DataColumn(label: Text('Total')),
    ],
    rows:
        ordersStatsData.entries.map((entry) {
          final status = entry.key;
          final count = entry.value;
          final total = cubit.totalAmount[status]!;
          return DataRow(
            cells: [
              DataCell(
                Row(
                  children: [
                    CircularContainer(
                      width: 20,
                      height: 20,
                      backgroundColor: HelperFunctions.getOrderStatusColor(
                        status,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(status.name),
                  ],
                ),
              ),
              DataCell(Text(count.toString())),
              DataCell(Text('\$${total.toStringAsFixed(2)}')),
            ],
          );
        }).toList(),
  );
}
