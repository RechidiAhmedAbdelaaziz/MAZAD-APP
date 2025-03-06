import 'package:flutter/material.dart';

class WrapSelector<T> extends StatefulWidget {
  final List<T> items;
  final T? selected;
  final void Function(T item) onSelect;
  final Widget Function(T item, bool isSelected) itemBuilder;

  final Axis direction;
  final double spacing;
  final double runSpacing;

  const WrapSelector({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
    required this.itemBuilder,
    this.direction = Axis.horizontal,
    this.spacing = 10,
    this.runSpacing = 10,
  });

  @override
  State<WrapSelector> createState() => _WrapSelectorState<T>();
}

class _WrapSelectorState<T> extends State<WrapSelector> {
  T? _selected;

  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      direction: widget.direction,
      children: widget.items
          .map(
            (item) => GestureDetector(
              onTap: () {
                setState(() => _selected = item);
                widget.onSelect(item);
              },
              child: widget.itemBuilder(item, item == _selected),
            ),
          )
          .toList(),
    );
  }
}
