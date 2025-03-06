import 'package:flutter/widgets.dart';
import 'package:mazad_app/core/extension/map.extension.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:mazad_app/core/shared/dto/form_dto.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';

abstract class AuctionDto extends FormDTO {
  final TextEditingController titleController;
  final TextEditingController regionController;
  final TextEditingController priceController;
  final EditingController<DateTime> endingDateController;

  AuctionDto({
    required this.titleController,
    required this.regionController,
    required this.priceController,
    required this.endingDateController,
  });

  bool get isNew;

  @override
  void dispose() {
    titleController.dispose();
    regionController.dispose();
    priceController.dispose();
    endingDateController.dispose();
  }
}

class CreateAuctionDto extends AuctionDto {
  CreateAuctionDto()
    : super(
        titleController: TextEditingController(),
        regionController: TextEditingController(),
        priceController: TextEditingController(),
        endingDateController: EditingController<DateTime>(
          DateTime.now(),
        ),
      );

  @override
  bool get isNew => true;

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'title': titleController.text,
      'region': regionController.text,
      'price': int.tryParse(priceController.text),
      'endingDate': endingDateController.value?.toIso8601String(),
    }.withoutNullsOrEmpty();
  }
}

class UpdateAuctionDto extends AuctionDto {
  final AuctionModel _auction;

  String get id => _auction.id!;

  UpdateAuctionDto(this._auction)
    : super(
        titleController: TextEditingController(text: _auction.title),
        regionController: TextEditingController(
          text: _auction.region,
        ),
        priceController: TextEditingController(
          text: _auction.subscriptionPrice.toString(),
        ),
        endingDateController: EditingController<DateTime>(
          _auction.endingDate,
        ),
      );

  @override
  Future<Map<String, dynamic>> toMap() async {
    final json = <String, dynamic>{};

    if (titleController.text != _auction.title) {
      json['title'] = titleController.text;
    }

    if (regionController.text != _auction.region) {
      json['region'] = regionController.text;
    }

    if (priceController.text !=
        _auction.subscriptionPrice.toString()) {
      json['price'] = int.tryParse(
        priceController.text,
      );
    }

    if (endingDateController.value != _auction.endingDate) {
      json['endingDate'] =
          endingDateController.value?.toIso8601String();
    }

    return json.withoutNullsOrEmpty();
  }

  @override
  bool get isNew => false;
}
