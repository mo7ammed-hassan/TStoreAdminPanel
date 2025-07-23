import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/loaders/animation_loader.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';
import 'package:t_store_admin_panel/features/order/cubits/order_cubit.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/table/table_scource.dart';

class OrderDataTable extends StatelessWidget {
  const OrderDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, BaseDataTableStates>(
      builder: (context, state) {
        if (state is DataTableLoadingState ||
            (state is DataTableLoadedState && state.data.isEmpty)) {
          return _buildLoaderOrEmptyWidget();
        }

        if (state is DataTableFailureState) {
          return _failureWidget(state.message);
        }
        return CustomPaginatedTable(
          minWidth: 700,
          columns: [
            const DataColumn2(label: Text('Order ID')),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Items')),
            DataColumn2(
              label: const Text('Status'),
              fixedWidth: DeviceUtilities.isMobileScreen(context) ? 120 : null,
            ),
            const DataColumn2(label: Text('Amount')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: AllOrdersRows(
            context,
            state is DataTableLoadedState
                ? (state.data as List<OrderModel>)
                : [],
            context.read<OrderCubit>(),
          ),
        );
      },
    );
  }

  Widget _buildLoaderOrEmptyWidget() {
    return const SizedBox(
      height: 700,
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'There are no orders.',
        animation: AppImages.packaging,
      ),
    );
  }

  Widget _failureWidget(String? error) {
    return Center(child: Text(error ?? 'Something went wrong!, Try again.'));
  }
}
