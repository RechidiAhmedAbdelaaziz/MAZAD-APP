import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/themes/colors.dart';

class KDropDownMenu extends StatefulWidget {
  final List<String> items;
  final TextEditingController controller;
  final String? title;
  final String? initialValue;
  final String? hintText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  const KDropDownMenu({
    super.key,
    this.title,
    required this.items,
    required this.controller,
    this.initialValue,
    this.hintText,
    this.prefixIcon,
    this.validator,
  });

  @override
  State<KDropDownMenu> createState() => _KDropDownMenuState();
}

class _KDropDownMenuState extends State<KDropDownMenu> {
  @override
  void initState() {
    widget.controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
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

        CustomDropdown.search(
          validator: widget.validator,
          decoration: CustomDropdownDecoration(
            errorStyle: TextStyle(
              color: KColors.red,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            closedBorder: Border.all(color: Colors.grey),
            prefixIcon: widget.prefixIcon,
            closedSuffixIcon:
                widget.controller.text.isNotEmpty
                    ? InkWell(
                      onTap: widget.controller.clear,
                      child: Icon(Icons.clear),
                    )
                    : null,
          ),
          items: widget.items,
          hintText: widget.hintText,
          listItemBuilder: (context, item, isSelected, onItemSelect) {
            return InkWell(
              onTap: onItemSelect,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color:
                      isSelected ? KColors.lightGrey : Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(children: [Text(item.tr(context))]),
              ),
            );
          },
          headerBuilder: (context, selectedItem, enabled) {
            return Text(
              selectedItem.tr(context),
              overflow: TextOverflow.ellipsis,
            );
          },
          initialItem:
              (widget.items.contains(widget.controller.text)
                  ? widget.controller.text
                  : widget.initialValue),
          onChanged: (value) {
            if (value != null) {
              widget.controller.text = value;
            }
          },
        ),
      ],
    );
  }
}
