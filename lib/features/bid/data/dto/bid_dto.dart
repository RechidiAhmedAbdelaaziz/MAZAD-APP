import 'package:mazad_app/core/extension/map.extension.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:mazad_app/core/shared/dto/form_dto.dart';
import 'package:mazad_app/features/bid/data/model/bid_model.dart';

abstract class BidDto extends FormDTO {
  final EditingController<int> amountController;
  final EditingController<int> quantityController;

  BidDto({
    required this.amountController,
    required this.quantityController,
  });

  @override
  void dispose() {
    amountController.dispose();
    quantityController.dispose();
  }
}

class CreateBidDto extends BidDto {
  CreateBidDto(int price)
    : super(
        amountController: EditingController(price),
        quantityController: EditingController(1),
      );

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'amount': amountController.value,
      'quantity': quantityController.value,
    }.withoutNullsOrEmpty();
  }
}

class UpdateBidDto extends BidDto {
  final BidModel _bid;

  UpdateBidDto(this._bid)
    : super(
        amountController: EditingController(_bid.amount),
        quantityController: EditingController(_bid.quantity),
      );

  String get bidId => _bid.id!;

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      if (_bid.amount != amountController.value)
        'amount': amountController.value,
      if (_bid.quantity != quantityController.value)
        'quantity': quantityController.value,
    }.withoutNullsOrEmpty();
  }
}
