part of 'filepick.service.dart';

class WebFilePicker extends ImagePickerService<WebImageDTO> {
  @override
  Future<WebImageDTO?> pickFile() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (xfile != null) {
      return WebImageDTO(file: xfile);
    } else {
      throw Exception("No file picked");
    }
  }
}
