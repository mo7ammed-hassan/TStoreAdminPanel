import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
