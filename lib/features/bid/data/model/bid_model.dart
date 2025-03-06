import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';
import 'package:mazad_app/features/user/source/model/user_model.dart';

part 'bid_model.g.dart';

@JsonSerializable(createToJson: false)
class BidModel extends Equatable {
  const BidModel({
    this.id,
    this.user,
    this.product,
    this.amount,
    this.quantity,
    this.status,
    this.createdAt,
  });

  @JsonKey(name: '_id')
  final String? id;

  final UserModel? user;
  final ProductModel? product;
  final int? amount;
  final int? quantity;
  final String? status;
  final String? createdAt;

  factory BidModel.fromJson(Map<String, dynamic> json) =>
      _$BidModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
