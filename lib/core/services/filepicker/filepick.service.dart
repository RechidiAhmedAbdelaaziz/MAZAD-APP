import 'dart:async';
import 'package:mazad_app/core/shared/dto/imagedto/image.dto.dart';
// import 'package:web/web.dart' as html;
import 'package:image_picker/image_picker.dart';

part 'web_filepicker.dart';
part 'mobile_filepicker.dart';

abstract class FilePickerService<T> {
  Future<T?> pickFile();
}

abstract class ImagePickerService<T extends LocalImageDTO>
    extends FilePickerService<T> {}
