import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/repo_base.dart';
import 'package:mazad_app/core/network/types/api_result.type.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/features/bid/data/model/bid_model.dart';
import 'package:mazad_app/features/bid/data/source/bid_api.dart';

class BidRepo extends NetworkRepository {
  final _bidApi = locator<BidApi>();

  RepoListResult<BidModel> getBids(
    String productId,
    PaginationDto dto,
  ) {
    return tryApiCall(() async {
      final response = await _bidApi.getBids(productId, dto.toJson());
      return PaginationResult.fromResponse(
        response: response,
        fromJson: (json) => BidModel.fromJson(json),
      );
    });
  }
}
