import 'package:flutter/material.dart';

import 'package:mazad_app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:mazad_app/core/shared/dto/imagedto/image.dto.dart';
import 'package:mazad_app/core/shared/widgets/image_widget.dart';

class ImageField extends StatelessWidget {
  final EditingController<ImageDTO> controller;
  final double? height;
  final double? width;
  final double? borderRadius;

  const ImageField({
    super.key,
    required this.controller,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ImageWidget(
      imageDto: controller.value,
      height: height,
      width: width,
      borderRadius: borderRadius,
      onPicked: (image) => controller.setValue(image),
      onEdited: (image) => controller.setValue(image),
      onDeleted: (image) => controller.clear(),
    );
  }
}
