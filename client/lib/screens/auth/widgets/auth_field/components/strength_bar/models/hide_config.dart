import 'package:flutter/material.dart';

class HideConfig {
  final ValueNotifier<bool> isHidden;
  bool get value => isHidden.value;
  set value(bool value) => isHidden.value = value;
  late void Function() onTap;

  void _setHidden() {
    value = !value;
  }

  HideConfig() : isHidden = ValueNotifier(true) {
    onTap = _setHidden;
  }

  HideConfig.custom({
    required this.isHidden,
    required this.onTap,
  });
}
