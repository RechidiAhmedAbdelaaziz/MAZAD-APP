import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/themes/colors.dart';

class AppTextFormField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const AppTextFormField({
    super.key,
    this.title,
    this.hintText,
    required this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.inputFormatters,
    this.maxLength,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Container(
          decoration: BoxDecoration(
            color: KColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextFormField(
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText ? _obscureText : false,
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            maxLength: widget.maxLength,
            maxLines:
                widget.keyboardType == TextInputType.multiline
                    ? null
                    : widget.maxLines,
            style: TextStyle(
              color: KColors.dark,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),

            decoration: InputDecoration(
              fillColor: KColors.white,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: KColors.grey,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon:
                  widget.prefixIcon == null
                      ? null
                      : Stack(
                        alignment: Alignment.center,
                        children: [widget.prefixIcon!],
                      ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24.h,
              ),
              suffixIcon:
                  widget.obscureText
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed:
                            () => setState(
                              () => _obscureText = !_obscureText,
                            ),
                      )
                      : null,
              // isCollapsed: true,
              // isDense: true,
              errorStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: KColors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              errorMaxLines: 3,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),

                borderSide: BorderSide(color: KColors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: KColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: KColors.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
