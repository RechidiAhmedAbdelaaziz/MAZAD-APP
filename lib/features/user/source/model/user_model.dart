import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel extends Equatable {
  const UserModel({this.id, this.name, this.phone, this.region});

  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? phone;
  final String? region;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
