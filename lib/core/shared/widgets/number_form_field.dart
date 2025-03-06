import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:mazad_app/core/shared/widgets/text_form_field.dart';

class ValuesFormField extends StatefulWidget {
  final ListEditingcontroller<int> controller;

  final String title;
  final int maxLength;

  final String? Function(List<int>? value)? validator;

  const ValuesFormField({
    super.key,
    required this.controller,
    required this.title,
    required this.maxLength,
    this.validator,
  });

  @override
  State<ValuesFormField> createState() => _ValuesFormFieldState();
}

class _ValuesFormFieldState extends State<ValuesFormField> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return FormField<List<int>>(
      validator:
          (value) => widget.validator?.call(widget.controller.value),
      builder:
          (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                      controller: controller,
                      title: widget.title,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: widget.maxLength,
                    ),
                  ),
                  widthSpace(8),
                  IconButton(
                    icon: Icon(Icons.add_box_rounded),
                    onPressed: () {
                      if (controller.text.isEmpty) return;

                      setState(() {
                        widget.controller.addValue(
                          int.parse(controller.text),
                        );
                      });
                    },
                  ),
                ],
              ),
              if (state.errorText != null)
                Text(
                  state.errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              heightSpace(8),
              ValueListenableBuilder(
                valueListenable: widget.controller,
                builder: (context, value, child) {
                  return Wrap(
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children:
                        value
                            .map(
                              (e) => Chip(
                                label: Text(e.toString()),
                                onDeleted: () {
                                  setState(() {
                                    widget.controller.removeValue(e);
                                  });
                                },
                              ),
                            )
                            .toList(),
                  );
                },
              ),
            ],
          ),
    );
  }
}
