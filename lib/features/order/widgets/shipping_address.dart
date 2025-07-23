import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/addrees_model.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key, required this.shippingAddress});
  final AddressModel? shippingAddress;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(shippingAddress?.userName ?? '', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          Text(
            '${shippingAddress?.city}, ${shippingAddress?.country}, ${shippingAddress?.street}, ${shippingAddress?.postalCode}' ,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
