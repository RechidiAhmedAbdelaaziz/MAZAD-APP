import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageIndicator extends StatefulWidget {
  final ScrollController controller;
  final int pageLength;
  const PageIndicator(
      {super.key,
      required this.controller,
      required this.pageLength});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  int _currentIndex = 0;

  @override
  void initState() {
    widget.controller.addListener(() {
      final index = (widget.controller.offset /
              widget.controller.position.maxScrollExtent *
              (widget.pageLength - 1))
          .round();
      if (index != _currentIndex) {
        setState(() {
          _currentIndex = index;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pageLength, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentIndex == index ? 20.w : 8.w,
          height: 8.h,
          margin:  EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: _currentIndex == index
                ? Colors.deepPurple
                : Colors.grey.shade300,
          ),
        );
      }),
    );
  }
}
