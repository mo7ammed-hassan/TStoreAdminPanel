import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that displays a toggle checkbox menu button
/// that uses a [BlocSelector] to determine its state and handle changes.
/// It allows for a customizable label and is useful for filtering or toggling options in a menu.
/// It is generic and can be used with any [Cubit] and state type.
/// [C] is the type of the Cubit, and [S] is the type
/// of the state managed by the Cubit.
/// The [selector] function is used to select the boolean value from the state,
/// and the [onChanged] function is called when the checkbox is toggled.
/// The [lable] parameter allows you to set a custom label for the checkbox.  
/// 
class ToggleCheckboxMenuButton<C extends Cubit<S>, S> extends StatelessWidget {
  const ToggleCheckboxMenuButton({
    super.key,
    required this.selector,
    required this.onChanged,
    this.lable = 'Featured',
  });
  final bool Function(S state) selector;
  final void Function(bool? value) onChanged;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<C, S, bool>(
      selector: selector,
      builder: (context, state) {
        return CheckboxMenuButton(
          value: state,
          onChanged: onChanged,
          child: Text(lable),
        );
      },
    );
  }
}
