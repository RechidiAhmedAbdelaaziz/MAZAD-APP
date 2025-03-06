import 'package:flutter/material.dart';

extension BottomSheetExtension on BuildContext {
  void showBottomSheet(Widget child) {
    showModalBottomSheet(
      context: this,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Stack(children: [child]),
    );
  }

  void bottomSheetWithResult<T>({
    required Widget child,
    required void Function(T) onResult,
    void Function()? onError,
  }) {
    showModalBottomSheet(
      context: this,
      backgroundColor: Colors.red,
      isScrollControlled: true,
      isDismissible: true,

      builder: (context) => child,
    ).then(
      (value) => value != null ? onResult(value) : onError?.call(),
    );
  }
}
