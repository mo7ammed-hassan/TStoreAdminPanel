import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

class OrdersRows extends DataTableSource {
  final isDark = HelperFunctions.isDarkMode(AppContext.context);
  @override
  DataRow? getRow(int index) {
    final order = OrderModel(
      orderId: '1',
      orderStatus: OrderStatus.shipped,
      totalAmount: 235.0,
      orderDate: DateTime.now(),
    );
    const totalAmout = '2235.0';
    return DataRow2(
      onTap:
          () => AppContext.context.pushNamedPage(
            Routes.orderDetail,
            arguments: order,
          ),
      cells: [
        DataCell(
          Text(
            '[#${order.orderId.toString()}]',
            style: Theme.of(
              AppContext.context,
            ).textTheme.bodyLarge!.apply(color: AppColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        const DataCell(Text('${5} Items')),

        DataCell(
          RoundedContainer(
            raduis: AppSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.sm,
              horizontal: AppSizes.md,
            ),
            backgroundColor: HelperFunctions.getOrderStatusColor(
              order.orderStatus!,
            ).withValues(alpha: 0.1),
            child: Text(
              order.orderStatus!.name.capitalize.toString(),
              style: TextStyle(
                color: HelperFunctions.getOrderStatusColor(order.orderStatus!),
              ),
            ),
          ),
        ),

        const DataCell(Text('\$$totalAmout')),
        
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
