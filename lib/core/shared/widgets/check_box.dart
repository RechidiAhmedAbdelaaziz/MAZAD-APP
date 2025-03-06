import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:mazad_app/core/themes/colors.dart';

class AppCheckBox extends StatefulWidget {
  final EditingController<bool> controller;
  final String title;
  const AppCheckBox({
    super.key,
    required this.controller,
    required this.title,
  });

  @override
  State<AppCheckBox> createState() => AppCheckBoxState();
}

class AppCheckBoxState extends State<AppCheckBox> {
  bool? _value;

  @override
  void initState() {
    _value = widget.controller.value;

    widget.controller.addListener(() {
      setState(() => _value = widget.controller.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 7.w,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            widget.controller.setValue(!(_value ?? false));
          },
          child: Icon(
            _value ?? false
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: KColors.dark,
            size: 30.sp,
          ),
        ),

        Text(
          widget.title,
          style: TextStyle(
            fontSize: 18.sp,
            color: KColors.dark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
