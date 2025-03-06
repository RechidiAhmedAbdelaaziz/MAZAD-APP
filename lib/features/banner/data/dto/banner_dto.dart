import 'package:flutter/widgets.dart';
import 'package:mazad_app/core/extension/map.extension.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:mazad_app/core/shared/dto/form_dto.dart';
import 'package:mazad_app/core/shared/dto/imagedto/image.dto.dart';
import 'package:mazad_app/features/banner/data/models/banner_model.dart';

abstract class BannerDto extends FormDTO {
  final TextEditingController titleController;
  final TextEditingController regionController;
  final EditingController<ImageDTO> imageController;

  BannerDto({
    required this.titleController,
    required this.regionController,
    required this.imageController,
  });

  @override
  void dispose() {
    titleController.dispose();
    regionController.dispose();
    imageController.dispose();
  }
}

class CreateBannerDto extends BannerDto {
  CreateBannerDto()
    : super(
        titleController: TextEditingController(),
        regionController: TextEditingController(),
        imageController: EditingController<ImageDTO>(),
      );

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'title': titleController.text,
      'region': regionController.text,
      'image': await imageController.value?.imageUrl,
    }.withoutNullsOrEmpty();
  } // 
}

class UpdateBannerDto extends BannerDto {
  final BannerModel _banner;

  String get id => _banner.id!;

  UpdateBannerDto(this._banner)
    : super(
        titleController: TextEditingController(text: _banner.title),
        regionController: TextEditingController(text: _banner.region),
        imageController: EditingController<ImageDTO>(
          RemoteImageDTO(url: _banner.imageUrl ?? ''),
        ),
      );

  @override
  Future<Map<String, dynamic>> toMap() async {
    final imageUrl = await imageController.value?.imageUrl;
    return {
      if (titleController.text != _banner.title)
        'title': titleController.text,

      if (regionController.text != _banner.region)
        'region': regionController.text,

      if (imageUrl != _banner.imageUrl) 'image': imageUrl,
    };
  }
}
