import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable(createToJson: false)
class BannerModel extends Equatable {
  const BannerModel({
    this.id,
    this.title,
    this.imageUrl,
    this.region,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? region;
  @JsonKey(name: 'image')
  final String? imageUrl;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
