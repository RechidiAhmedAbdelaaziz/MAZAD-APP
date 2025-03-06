import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';

part 'product_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductModel extends Equatable {
  const ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.images,
    this.stock,
    this.suggestedPrices,
    this.auction,
    this.category,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? description;
  final int? price;
  final List<String>? images;
  final int? stock;
  final List<int>? suggestedPrices;
  final AuctionModel? auction;
  final String? category;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  @override
  List<Object?> get props => [id];
}

