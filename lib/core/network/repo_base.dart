import 'package:flutter/material.dart';

import 'api_error.handler.dart';
import 'types/api_result.type.dart';

typedef RepoResult<T> = Future<ApiResult<T>>;
typedef RepoListResult<T> = Future<ApiResult<PaginationResult<T>>>;

class NetworkRepository {
  Future<ApiResult<T>> tryApiCall<T>(
      Future<T> Function() apiCall) async {
    try {
      return ApiResult.success(await apiCall());
    } catch (error) {
      debugPrint(
          '\n\n!!!\n TryCallApi error: ${error.toString()} \n!!!\n\n');
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }
}
