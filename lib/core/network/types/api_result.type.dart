import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mazad_app/core/extension/list.extension.dart';
import 'package:mazad_app/core/network/models/api_error.model.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';

part 'api_result.type.freezed.dart';

@Freezed()
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = _Success<T>;
  const factory ApiResult.error(ApiErrorModel errorHandler) =
      _Failure<T>;
}

class PaginationResult<T> {
  final Pagination pagination;
  final List<T> data;

  PaginationResult({
    this.pagination = const Pagination(),
    List<T>? data,
  }) : data = data ?? [];

  PaginationResult<T> add(T item) =>
      copyWith(data: data.withUnique(item));

  PaginationResult<T> addAll(PaginationResult<T> result) => copyWith(
    data: data.withAllUnique(result.data),
    pagination: result.pagination,
  );

  PaginationResult<T> remove(T item) =>
      copyWith(data: data.without(item));

  PaginationResult<T> replace(T item) =>
      copyWith(data: data.withReplace(item));

  PaginationResult<T> copyWith({
    Pagination? pagination,
    List<T>? data,
  }) {
    return PaginationResult(
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  void clear() => data.clear();

  PaginationResult.fromResponse({
    required PaginatedDataResponse response,
    required T Function(Map<String, dynamic>) fromJson,
  }) : pagination = response.pagination ?? const Pagination(),
       data = response.data!.map((e) => fromJson(e)).toList();
}
