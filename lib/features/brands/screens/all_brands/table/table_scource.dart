import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/features/brands/cubits/brand_cubit.dart';

class BrandRows extends DataTableSource {
  final List<BrandModel> brands;
  final BrandCubit brandCubit;
  final BuildContext context;

  BrandRows(this.brands, this.brandCubit, this.context);
  @override
  DataRow? getRow(int index) {
    if (index >= brands.length) return null;
    final BrandModel brand = brands[index];
    return DataRow2(
      key: ValueKey(brand.id),
      selected: brandCubit.selectedItems[index],
      onSelectChanged: (value) => brandCubit.toggleSelection(index, value!),
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image: brand.image ?? AppImages.defaultImage,
                width: 50,
                height: 50,
                imageType:
                    brand.image != null ? ImageType.network : ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  brand.name,
                  style: Theme.of(
                    AppContext.context,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: AppSizes.xs,
                direction:
                    DeviceUtilities.isMobileScreen(AppContext.context)
                        ? Axis.vertical
                        : Axis.horizontal,
                children:
                    brand.brandCategories != null
                        ? brand.brandCategories!
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      DeviceUtilities.isMobileScreen(
                                            AppContext.context,
                                          )
                                          ? 0
                                          : AppSizes.xs,
                                ),
                                child: Chip(
                                  label: Text(e.name),
                                  padding: const EdgeInsets.all(AppSizes.xs),
                                ),
                              ),
                            )
                            .toList()
                        : [const SizedBox.shrink()],
              ),
            ),
          ),
        ),
        DataCell(
          brand.isFeatured ?? false
              ? const Icon(Iconsax.heart5, color: AppColors.primary)
              : const Icon(Iconsax.heart, color: Colors.grey),
        ),
        DataCell(Text(brand.formattedCreatedAt ?? '')),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => context.read<SidebarCubit>().screenOnTap(
                  SidebarRoutes.editBrand,
                  arguments: brand,
                ),
            onDeletePressed:
                () async => await brandCubit.deleteOnConfirmation(brand),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => brands.length;

  @override
  int get selectedRowCount =>
      brandCubit.selectedItems.where((e) => e == true).length;
}
