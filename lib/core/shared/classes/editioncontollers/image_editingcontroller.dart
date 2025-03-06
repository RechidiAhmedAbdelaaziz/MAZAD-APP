import 'package:flutter/foundation.dart';
import 'package:mazad_app/core/shared/dto/imagedto/image.dto.dart';

class ImageEditingController extends ValueNotifier<ImageDTO?> {
  ImageEditingController([super._value]);

  void setImage(ImageDTO? image) => value = image;

  void removeImage() => value = null;
}
