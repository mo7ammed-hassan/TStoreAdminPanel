import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

class OrderInfoSection extends StatelessWidget {
  const OrderInfoSection({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date'),
                      Text(
                        order.formattedOrderDate,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.xs),
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Items'),
                      Text(
                        '${order.cartItems?.length} - Items',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.xs),
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Status'),
                      RoundedContainer(
                        raduis: AppSizes.cardRadiusSm,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.sm,
                        ),
                        backgroundColor: HelperFunctions.getOrderStatusColor(
                          order.orderStatus!,
                        ).withValues(alpha: 0.1),
                        child: FittedBox(
                          child: DropdownButton<OrderStatus>(
                            padding: EdgeInsets.zero,
                            items:
                                OrderStatus.values
                                    .map(
                                      (e) => DropdownMenuItem<OrderStatus>(
                                        value: e,
                                        child: Text(
                                          HelperFunctions.upperCaseFirst(
                                            e.name,
                                          ),
                                          style: TextStyle(
                                            color:
                                                HelperFunctions.getOrderStatusColor(
                                                  e,
                                                ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            value: order.orderStatus,
                            onChanged: (value) {
                              if (value != null) {}
                            },
                            dropdownColor: AppColors.primaryBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total'),
                      Text(
                        '\$${order.totalAmount}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
