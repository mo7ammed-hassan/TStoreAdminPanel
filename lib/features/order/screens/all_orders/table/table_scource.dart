import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/features/order/cubits/order_cubit.dart';

class AllOrdersRows extends DataTableSource {
  final BuildContext context;
  final List<OrderModel> orders;
  final OrderCubit orderCubit;

  AllOrdersRows(this.context, this.orders, this.orderCubit);
  @override
  DataRow? getRow(int index) {
    final order = orders[index];
    if (orders.isEmpty) {
      return null;
    }

    return DataRow2(
      onTap:
          () => context.read<SidebarCubit>().screenOnTap(
            SidebarRoutes.orderDetails,
            arguments: order,
          ),
      cells: [
        DataCell(
          Text(
            order.orderId.toString(),
            style: Theme.of(
              AppContext.context,
            ).textTheme.bodyLarge!.apply(color: AppColors.primary),
          ),
        ),
        DataCell(Text(order.formattedDeliveryDate)),
        DataCell(Text('${order.cartItems?.length ?? 0} Items')),
        DataCell(
          RoundedContainer(
            raduis: AppSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.sm,
              horizontal: AppSizes.md,
            ),
            backgroundColor: HelperFunctions.getOrderStatusColor(
              order.orderStatus ?? OrderStatus.delivered,
            ).withValues(alpha: 0.1),
            child: Text(
              HelperFunctions.upperCaseFirst(order.orderStatus?.name ?? ''),
              style: TextStyle(
                color: HelperFunctions.getOrderStatusColor(order.orderStatus!),
              ),
            ),
          ),
        ),

        DataCell(Text('\$${order.totalAmount}')),
        DataCell(
          TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed:
                () => context.read<SidebarCubit>().screenOnTap(
                  SidebarRoutes.orderDetails,
                  arguments: order,
                ),
            onDeletePressed: () => orderCubit.deleteOnConfirmation(order),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount =>
      orderCubit.selectedItems.where((e) => e == true).length;
}
