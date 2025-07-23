import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/loaders/animation_loader.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/features/customers/cubits/customer_cubit.dart';
import 'package:t_store_admin_panel/features/customers/screens/all_customers/table/table_scource.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';

class CustomerDataTable extends StatelessWidget {
  const CustomerDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, BaseDataTableStates>(
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
          columns: const [
            DataColumn2(label: Text('Customer')),
            DataColumn2(label: Text('Email')),
            DataColumn2(label: Text('Phone Number')),
            DataColumn2(label: Text('Registered')),
            DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: CustomerRows(
            context,
            state is DataTableLoadedState<UserModel> ? state.data : [],
            context.read<CustomerCubit>(),
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
        text: 'There are no customers.',
        animation: AppImages.packaging,
      ),
    );
  }

  Widget _failureWidget(String? error) {
    return Center(child: Text(error ?? 'Something went wrong!, Try again.'));
  }
}
