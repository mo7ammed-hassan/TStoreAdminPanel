import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_states.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.itemName,
    required this.icon,
    required this.route,
  });
  final String itemName;
  final IconData icon;
  final SidebarRoutes route;

  @override
  Widget build(BuildContext context) {
    final menuCubit = context.read<SidebarCubit>();
    return InkWell(
      onTap: () => menuCubit.menuOnTap(context, route),
      onHover:
          (hovering) =>
              hovering
                  ? menuCubit.changeHoverItem(route)
                  : menuCubit.changeHoverItem(null),

      child: BlocBuilder<SidebarCubit, SidebarStates>(
        buildWhen: (previous, current) => current is SidebarHoverChanged,
        builder: (context, state) {
          final isActive = menuCubit.isActive(route);
          final isHovering = menuCubit.isHovering(route);
          final shouldScale = isActive || isHovering;
          final scaleValue = shouldScale ? 1.05 : 1.0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color:
                    menuCubit.isHovering(route) || menuCubit.isActive(route)
                        ? AppColors.primary
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: scaleValue),
                duration: const Duration(milliseconds: 250),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: AppSizes.lg,
                            top: AppSizes.md,
                            bottom: AppSizes.md,
                            right: AppSizes.md,
                          ),
                          child:
                              menuCubit.isActive(route)
                                  ? Icon(icon, size: 22, color: AppColors.white)
                                  : Icon(
                                    icon,
                                    size: 22,
                                    color:
                                        menuCubit.isHovering(route)
                                            ? AppColors.white
                                            : AppColors.darkGrey,
                                  ),
                        ),

                        Flexible(
                          // if the text is too long, it will be wrapped to multiple lines
                          child: AnimatedDefaultTextStyle(
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.apply(
                              color:
                                  shouldScale
                                      ? AppColors.white
                                      : AppColors.darkGrey,
                            ),
                            duration: const Duration(milliseconds: 250),
                            child: Text(itemName),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
