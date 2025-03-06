import 'package:flutter/foundation.dart';

class IntegerEditingController extends ValueNotifier<int> {
  IntegerEditingController([super._value = 0]);

  void setValue(int value) => super.value = value;

  void increment([int step = 1]) {
    value += step;
  }

  void decrement([int step = 1]) {
    value -= step;
  }
}
