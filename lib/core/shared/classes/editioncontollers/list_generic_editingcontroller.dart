import 'package:flutter/material.dart';
import 'package:mazad_app/core/extension/list.extension.dart';

class ListEditingcontroller<T> extends ValueNotifier<List<T>> {
  ListEditingcontroller([List<T>? value]) : super(value ?? []);

  void addValue(T value) {
    this.value.addUnique(value);
    notifyListeners();
  }

  void removeValue(T value) {
    this.value.remove(value);
    notifyListeners();
  }

  void replaceValue(T value) {
    this.value.replace(value);
    notifyListeners();
  }

  void replaceAt(int index, T value) {
    this.value[index] = value;
    notifyListeners();
  }

  void clear() {
    value = [];
    notifyListeners();
  }

  void addValues(List<T> values) => value.addAllUnique(values);

  void removeValues(List<T> values) =>
      value.removeWhere((element) => values.contains(element));

  void setList(List<T> value) => this.value = value;
}
