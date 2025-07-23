import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/circular_image.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/features/customers/cubits/customer_cubit.dart';

class CustomerRows extends DataTableSource {
  final BuildContext context;
  final List<UserModel> customers;
  final CustomerCubit customerCubit;

  CustomerRows(this.context, this.customers, this.customerCubit);
  @override
  DataRow? getRow(int index) {
    final customer = customers[index];

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const CircularImage(
                image: AppImages.user,
                width: 50,
                height: 50,
                padding: AppSizes.xs,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  customer.userFullName ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    AppContext.context,
                  ).textTheme.bodyLarge!.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(customer.userEmail)),
        DataCell(Text(customer.userPhone ?? '')),
        DataCell(Text(customer.createdAt.toString())),
        DataCell(
          TTableActionButtons(
            edit: false,
            view: true,
            onViewPressed:
                () => context.read<SidebarCubit>().screenOnTap(
                  SidebarRoutes.customerDetails,
                  arguments: customer,
                ),
            onDeletePressed: () => customerCubit.deleteItem(customer),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => customers.length;

  @override
  int get selectedRowCount => customerCubit.selectedItems.length;
}
