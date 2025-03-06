part of 'image.dto.dart';

abstract class LocalImageDTO extends ImageDTO {
  final XFile file;
  final _cloudStorageService = locator<ImageCloudStorageService>();

  LocalImageDTO({required this.file});

  @override
  ImageProvider get image;

  @override
  Future<String> get imageUrl async =>
      await _cloudStorageService.upload(file);
}

class MobileImageDTO extends LocalImageDTO {
  MobileImageDTO({required super.file});

  @override
  ImageProvider get image => FileImage(File(file.path));
}

class WebImageDTO extends LocalImageDTO {
  WebImageDTO({required super.file});

  @override
  ImageProvider get image => NetworkImage(file.path);
}
