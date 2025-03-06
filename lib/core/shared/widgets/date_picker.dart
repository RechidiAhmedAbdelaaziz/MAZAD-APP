import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:mazad_app/core/themes/colors.dart';

class KDatePicker extends StatefulWidget {
  const KDatePicker({
    super.key,
    required this.controller,
    this.firstDate,
    this.lastDate,
    this.title,
  });

  final EditingController<DateTime> controller;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? title;

  @override
  State<KDatePicker> createState() => _KDatePickerState();
}

class _KDatePickerState extends State<KDatePicker> {
  DateTime? date;

  @override
  void initState() {
    date = widget.controller.value;

    widget.controller.addListener(() {
      setState(() => date = widget.controller.value);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: widget.firstDate ?? DateTime(2000),
          lastDate:
              widget.lastDate ?? DateTime(DateTime.now().year + 5),
        );

        if (selectedDate != null) {
          widget.controller.setValue(selectedDate);
          setState(() => date = selectedDate);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.spMax,
                fontWeight: FontWeight.w600,
              ),
            ),
            heightSpace(5),
          ],
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 8.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                widthSpace(12),
                Expanded(
                  child: Text(
                    date != null
                        ? _formatDate(date!)
                        : '${'SelectDate'.tr(context)}...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color:
                          date != null
                              ? KColors.black
                              : KColors.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
