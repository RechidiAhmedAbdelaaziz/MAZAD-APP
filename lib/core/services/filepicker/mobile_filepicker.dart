part of 'filepick.service.dart';

class MobileFilePicker extends ImagePickerService<MobileImageDTO> {
  @override
  Future<MobileImageDTO?> pickFile() async {
    final imagePicker = ImagePicker();
    final xfile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    return xfile != null ? MobileImageDTO(file: xfile) : null;
  }
}
