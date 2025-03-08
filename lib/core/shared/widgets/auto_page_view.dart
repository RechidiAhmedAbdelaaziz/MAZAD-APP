import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/themes/colors.dart';

class AppPageView<T> extends StatefulWidget {
  final List<T> items;
  final Widget? Function(T item) itemBuilder;
  final double height;
  final bool autoPlay;

  const AppPageView({
    super.key,
    required this.itemBuilder,
    required this.height,
    required this.items,
    this.autoPlay = true,
  });

  @override
  State<AppPageView<T>> createState() => _AppPageViewState<T>();
}

class _AppPageViewState<T> extends State<AppPageView<T>> {
  late Timer _timer;
  int _currentIndex = 0;

  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  @override
  void initState() {
    if (widget.autoPlay) {
      _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
        if (_currentIndex < widget.items.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }

        setState(() {});

        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      });
    }

    _pageController.addListener(() {
      if (_pageController.page != null) {
        _currentIndex = _pageController.page!.round();
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          width: double.infinity,
          child: PageView.builder(
            itemCount: widget.items.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _currentIndex == index ? 1 : 0.5,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  margin:
                      _currentIndex != index
                          ? EdgeInsets.symmetric(vertical: 25.h)
                          : EdgeInsets.zero,

                  child: widget.itemBuilder(widget.items[index]),
                ),
              );
            },
          ),
        ),

        heightSpace(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 350),
              curve: Curves.easeIn,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              width: index == _currentIndex ? 20.w : 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                color:
                    _currentIndex == index
                        ? KColors.primary
                        : Colors.grey,
                borderRadius: BorderRadius.circular(8).r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
