
import 'package:image_picker/image_picker.dart';

abstract class _CloudStorageService<TFile> {
  Future<String> upload(TFile file);
}

abstract class ImageCloudStorageService extends _CloudStorageService<XFile> {}