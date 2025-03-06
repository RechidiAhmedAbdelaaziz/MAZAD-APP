import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/repo_base.dart';
import 'package:mazad_app/core/network/types/api_result.type.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/features/auction/data/dto/auction_dto.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';
import 'package:mazad_app/features/auction/data/source/auction_api.dart';

class AuctionRepo extends NetworkRepository {
  final _auctionApi = locator<AuctionApi>();

  RepoListResult<AuctionModel> getAuctions(PaginationDto dto) {
    return tryApiCall(() async {
      final response = await _auctionApi.getAuctions(dto.toJson());
      return PaginationResult.fromResponse(
        response: response,
        fromJson: AuctionModel.fromJson,
      );
    });
  }

  RepoResult<AuctionModel> getAuction(String id) {
    return tryApiCall(() async {
      final response = await _auctionApi.getAuction(id);
      return AuctionModel.fromJson(response.data!);
    });
  }

  RepoResult<AuctionModel> createAuction(CreateAuctionDto dto) {
    return tryApiCall(() async {
      final response = await _auctionApi.createAuction(
        await dto.toMap(),
      );
      return AuctionModel.fromJson(response.data!);
    });
  }

  RepoResult<AuctionModel> updateAuction(UpdateAuctionDto dto) {
    return tryApiCall(() async {
      final response = await _auctionApi.updateAuction(
        dto.id,
        await dto.toMap(),
      );
      return AuctionModel.fromJson(response.data!);
    });
  }

  RepoResult<void> deleteAuction(AuctionModel auction) {
    return tryApiCall(
      () async => await _auctionApi.deleteAuction(auction.id!),
    );
  }
}
