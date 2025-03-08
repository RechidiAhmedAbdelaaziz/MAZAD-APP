import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/repo_base.dart';
import 'package:mazad_app/core/network/types/api_result.type.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/features/bid/data/dto/bid_dto.dart';
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

  RepoListResult<BidModel> getMyBids(PaginationDto dto) {
    return tryApiCall(() async {
      final response = await _bidApi.getMyBids(dto.toJson());
      return PaginationResult.fromResponse(
        response: response,
        fromJson: (json) => BidModel.fromJson(json),
      );
    });
  }

  RepoResult<BidModel> getBid(String bidId) {
    return tryApiCall(() async {
      final response = await _bidApi.getBid(bidId);
      return BidModel.fromJson(response.data!);
    });
  }

  RepoResult<BidModel> createBid(String productId, CreateBidDto dto) {
    return tryApiCall(() async {
      final response = await _bidApi.createBid(
        productId,
        await dto.toMap(),
      );
      return BidModel.fromJson(response.data!);
    });
  }

  RepoResult<BidModel> updateBid(UpdateBidDto dto) {
    return tryApiCall(() async {
      final response = await _bidApi.updateBid(
        dto.bidId,
        await dto.toMap(),
      );
      return BidModel.fromJson(response.data!);
    });
  }
}
