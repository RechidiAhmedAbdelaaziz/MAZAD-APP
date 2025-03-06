import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';

class MultiDropDownMenu extends StatefulWidget {
  final List<String> items;
  final ListEditingcontroller<String> controller;
  final String? title;
  final List<String>? initialValue;
  final String? Function(List<String>? items)? validator;

  const MultiDropDownMenu({
    super.key,
    required this.items,
    required this.controller,
    this.title,
    this.initialValue,
    this.validator,
  });

  @override
  State<MultiDropDownMenu> createState() => _MultiDropDownMenuState();
}

class _MultiDropDownMenuState extends State<MultiDropDownMenu> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Row(
          children: [
            if (widget.title != null)
              Text(
                widget.title!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.spMax,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const Spacer(),
            if (widget.controller.value.isNotEmpty)
              InkWell(
                onTap: widget.controller.clear,
                child: Icon(Icons.restore),
              ),
          ],
        ),
        FormField<List<String>>(
          validator: widget.validator,
          initialValue: widget.controller.value,
          builder: (state) {
            return Column(
              children: [
                CustomDropdown.multiSelectSearch(
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(color: Colors.grey),
                  ),
                  items: widget.items,
                  onListChanged: widget.controller.setList,
                  initialItems: widget.controller.value,
                ),
                if (state.hasError)
                  Text(
                    state.errorText!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.spMax,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
