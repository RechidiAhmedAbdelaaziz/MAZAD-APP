import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:mazad_app/core/shared/dto/imagedto/image.dto.dart';
import 'package:mazad_app/core/shared/widgets/image_widget.dart';

class ImagesField extends StatefulWidget {
  final ListEditingcontroller<ImageDTO> controller;

  final double height;
  final double? width;
  final double? borderRadius;

  const ImagesField({
    super.key,
    required this.controller,
    required this.height,
    this.width,
    this.borderRadius,
  });

  @override
  State<ImagesField> createState() => _ImagesFieldState();
}

class _ImagesFieldState extends State<ImagesField> {
  final _pageController = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    widget.controller.addListener(
      () => setState(() {
        // _pageController.jumpToPage(widget.controller.value.length);
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.controller.value.length + 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ImageWidget(
              height: widget.height,
              width: widget.width,
              borderRadius: widget.borderRadius,
              imageDto:
                  index < widget.controller.value.length
                      ? widget.controller.value[index]
                      : null,
              onDeleted: widget.controller.removeValue,
              onPicked: (image) {
                widget.controller.setList([
                  ...widget.controller.value,
                  image,
                ]);
              },
              onEdited:
                  (image) =>
                      widget.controller.replaceAt(index, image),
            ),
          );
        },
      ),
    );
  }
}
