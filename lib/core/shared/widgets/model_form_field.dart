import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/dialog.extension.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:mazad_app/core/themes/colors.dart';

class ModelFormField<T> extends StatefulWidget {
  final EditingController<T> controller;

  final String? title;

  final Widget Function(T item) builder;
  final Widget Function() formBuilder;

  final String? Function(T?)? validator;

  const ModelFormField({
    super.key,
    required this.controller,
    this.title,
    required this.builder,
    required this.formBuilder,
    this.validator,
  });

  @override
  State<ModelFormField<T>> createState() => _ModelFormFieldState<T>();
}

class _ModelFormFieldState<T> extends State<ModelFormField<T>> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator:
          (value) => widget.validator?.call(widget.controller.value),
      builder:
          (state) => Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (widget.title != null)
                    Text(
                      widget.title!,
                      style: TextStyle(
                        color: KColors.dark,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const Spacer(),
                  if (widget.controller.value != null) ...[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: _selectItem,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: widget.controller.clear,
                    ),
                  ],
                ],
              ),
              widget.controller.value != null
                  ? widget.builder(widget.controller.value!)
                  : _buildSelectButton(),

              if (state.hasError)
                Text(
                  state.errorText!,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: KColors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
    );
  }

  Widget _buildSelectButton() {
    return ElevatedButton(
      onPressed: _selectItem,
      child: Text('Select'.tr(context)),
    );
  }

  void _selectItem() {
    context.dialogWith<T>(
      child: widget.formBuilder(),
      onResult: widget.controller.setValue,
    );
  }
}
