import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Person',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(userModel?.userFullName ?? '', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          Text(
            userModel?.userEmail ?? '',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          Text(userModel?.userPhone ?? '', style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
