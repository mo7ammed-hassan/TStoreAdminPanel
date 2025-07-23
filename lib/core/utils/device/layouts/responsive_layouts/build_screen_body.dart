import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_states.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/extensions/sidebar_extension.dart';

class BuildScreenBody extends StatelessWidget {
  const BuildScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SidebarCubit, SidebarStates>(
      buildWhen:
          (previous, current) =>
              current is SidebarItemChanged ||
              current is SidebarSubRouteNavigated,
      builder: (context, state) {
        final cubit = context.read<SidebarCubit>();
        // final route =
        //     state is NavigateToSubRouteState ? state.route : cubit.activeItem;
        final SidebarRoutes route = cubit.extractScreenRoute(state);

        final arguments =
            state is SidebarSubRouteNavigated ? state.arguments : null;

        return AnimatedSwitcher(
          // animated switcher to switch between screens
          duration: const Duration(milliseconds: 250),
          child: _buildScreen(route, arguments, context),
        );
      },
    );
  }

  Widget _buildScreen(
    SidebarRoutes route,
    dynamic arguments,
    BuildContext context,
  ) {
    final screen =
        arguments == null ? route.screen : route.screenWithArguments(arguments);

    return KeyedSubtree(
      // keyed subtree to save state and avoid rebuild of screen
      key: ValueKey(route),
      child: PopScope(
        // pop scope to handle back button
        canPop: route == SidebarRoutes.dashboard ? true : false,
        onPopInvokedWithResult:
            (didPop, result) => context.read<SidebarCubit>().onBackPressed(),
        child: screen ?? const SizedBox(),
      ),
    );
  }
}

// class BuildScreenBody extends StatelessWidget {
//   const BuildScreenBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SidebarCubit, SidebarStates>(
//       buildWhen:
//           (previous, current) =>
//               current is ChangeActiveItemState ||
//               current is ChangeActiveSubItemState,
//       builder: (context, state) {
//         /// get route
//         /// Destructuring pattern matching
//         /// Object Pattern with Field Extraction
//         final SidebarRoutes route = switch (state) {
//           ChangeActiveSubItemState(:final route) => route,
//           ChangeActiveItemState(:final route) => route,
//           _ => context.read<SidebarCubit>().activeItem,
//         };

//         // get arguments if found
//         final arguments =
//             state is ChangeActiveSubItemState ? state.arguments : null;

//         final Widget? screen =
//             arguments == null
//                 ? route.screen
//                 : route.screenWithArguments(arguments);

//         return PopScope(
//           canPop: route == SidebarRoutes.dashboard ? true : false,
//           onPopInvokedWithResult:
//               (didPop, result) => context.read<SidebarCubit>().onBackPressed(),
//           child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300),
//             child: screen ?? const SizedBox(),
//           ),
//         );
//       },
//     );
//   }
// }




/*
 final route = context.select((SidebarCubit cubit) => cubit.activeItem);
    final arguments = null;
    return AnimatedSwitcher(
      // animated switcher to switch between screens
      duration: const Duration(milliseconds: 250),
      child: _buildScreen(route, arguments, context),
    );
 */