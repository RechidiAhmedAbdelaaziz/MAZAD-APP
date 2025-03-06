import 'package:flutter/material.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/services/filepicker/filepick.service.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/dto/imagedto/image.dto.dart';
import 'package:mazad_app/core/themes/colors.dart';

class ImageWidget extends StatefulWidget {
  final ImageDTO? imageDto;

  final double? height;
  final double? width;
  final double? borderRadius;

  final ValueChanged<ImageDTO> onPicked;
  final ValueChanged<ImageDTO>? onEdited;
  final ValueChanged<ImageDTO>? onDeleted;

  const ImageWidget({
    super.key,
    this.imageDto,
    this.height,
    this.width,
    this.borderRadius,
    required this.onPicked,
    this.onDeleted,
    this.onEdited,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  ImageDTO? _imageDTO;

  @override
  void initState() {
    _imageDTO = widget.imageDto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isPicked = _imageDTO != null;
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: KColors.lightGrey,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
        image:
            isPicked
                ? DecorationImage(
                  image: _imageDTO!.image,
                  fit: BoxFit.cover,
                )
                : null,
      ),
      child:
          !isPicked
              ? IconButton(
                icon: Icon(Icons.add_a_photo, color: KColors.black),
                onPressed: () => _uploadImage(widget.onPicked),
              )
              : Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.onDeleted != null)
                      CircleAvatar(
                        backgroundColor: KColors.white,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: KColors.red,
                          ),
                          onPressed: () {
                            widget.onDeleted?.call(_imageDTO!);
                            setState(() => _imageDTO = null);
                          },
                        ),
                      ),
                    widthSpace(4),
                    if (widget.onEdited != null)
                      CircleAvatar(
                        backgroundColor: KColors.white,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: KColors.black,
                          ),
                          onPressed:
                              () => _uploadImage(widget.onEdited!),
                        ),
                      ),
                  ],
                ),
              ),
    );
  }

  void _uploadImage(ValueChanged<ImageDTO> onPicked) async {
    final image = await locator<ImagePickerService>().pickFile();
    if (image != null) {
      onPicked(image);
      setState(() => _imageDTO = image);
    }
  }
}
