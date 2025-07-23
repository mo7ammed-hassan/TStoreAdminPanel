import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';

class ResponsiveScreens extends StatelessWidget {
  const ResponsiveScreens({
    super.key,
    required this.desktop,
    this.tablet,
    this.mobile,
  });

  final Widget? desktop;
  final Widget? tablet;
  final Widget? mobile;

  @override
  Widget build(BuildContext context) {
    return SlideFromBottomScreen(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (context.width < DeviceUtilities.tablet) {
            return mobile ?? desktop ?? const SizedBox();
          } else if (context.width < DeviceUtilities.desktop &&
              context.width >= DeviceUtilities.tablet) {
            return tablet ?? desktop ?? const SizedBox();
          } else {
            return desktop ?? const SizedBox();
          }
        },
      ),
    );
  } // 1528 > 1300
}

class SlideFromBottomScreen extends StatelessWidget {
  const SlideFromBottomScreen({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOut,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
      duration: duration,
      curve: curve,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: Offset(0, offset.dy * 40),
          child: child,
        );
      },
      child: child,
    );
  }
}
