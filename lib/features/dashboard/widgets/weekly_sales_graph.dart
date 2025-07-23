import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/features/dashboard/cubits/dashboard_cubit.dart';

class WeeklySalesGraph extends StatelessWidget {
  const WeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DashboardCubit>(context);
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Sales',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          SizedBox(
            height: 400,
            child: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, weeklySales) {
                return BarChart(
                  BarChartData(
                    titlesData: _buildTitleData(),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(),
                    ),
                    gridData: const FlGridData(horizontalInterval: 200),
                    barGroups: _buildBarGroups(cubit.weeklySales),
                    groupsSpace: AppSizes.spaceBtwItems,
                    barTouchData: _buildBarTouchData(context),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  FlTitlesData _buildTitleData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final index = value.toInt() % days.length;
            return SideTitleWidget(meta: meta, child: Text(days[index]));
          },
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 200,
          reservedSize: 50,
        ),
      ),
      topTitles: const AxisTitles(),
      rightTitles: const AxisTitles(),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<double> weeklySales) {
    return weeklySales.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            width: 30,
            toY: entry.value,
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSizes.sm),
          ),
        ],
      );
    }).toList();
  }

  BarTouchData _buildBarTouchData(BuildContext context) {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (_) => AppColors.secondary,
      ),
      touchCallback:
          DeviceUtilities.isDesktopScreen(context)
              ? null
              : (event, response) {},
    );
  }
}
