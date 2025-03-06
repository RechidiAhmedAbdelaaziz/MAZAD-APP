import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auction_model.g.dart';

@JsonSerializable(createToJson: false)
class AuctionModel extends Equatable {
  const AuctionModel({
    this.id,
    this.productsNumber,
    this.title,
    this.endingDate,
    this.region,
    this.subscriptionPrice,
  });

  @JsonKey(name: '_id')
  final String? id;
  final int? productsNumber;
  final String? title;
  final DateTime? endingDate;
  final String? region;
  @JsonKey(name: 'price')
  final int? subscriptionPrice;
  // status , categoties ,

  factory AuctionModel.fromJson(Map<String, dynamic> json) =>
      _$AuctionModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
