import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/themes/colors.dart';

class SubmitButton extends StatefulWidget {
  final bool isLoading;
  final void Function() onTap;
  final String title;

  final Color color;
  final Color textColor;
  final Color? borderColor;

  final List<ValueNotifier>? controllers;
  final bool Function()? validCheck;

  const SubmitButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.color = KColors.primary,
    this.textColor = KColors.white,
    this.borderColor,
    this.controllers,
    this.validCheck,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isEnable = true;

  @override
  void initState() {
    widget.controllers?.forEach((element) {
      element.addListener(() {
        setState(
          () => _isEnable = widget.validCheck?.call() ?? false,
        );
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isEnable ? widget.onTap : null,
      child: Stack(
        children: [
          Container(
            height: 55.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color:
                  _isEnable
                      ? widget.color
                      : widget.color.withAlpha((255 * 0.2).toInt()),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              border: Border.all(
                color: widget.borderColor ?? widget.color,
              ),
            ),
            alignment: Alignment.center,
            child:
                widget.isLoading
                    ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.textColor,
                      ),
                    )
                    : Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: 20.spMax,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
