import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/repo_base.dart';
import 'package:mazad_app/core/network/types/api_result.type.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/features/banner/data/dto/banner_dto.dart';
import 'package:mazad_app/features/banner/data/models/banner_model.dart';
import 'package:mazad_app/features/banner/data/source/banner_api.dart';

class BannerRepo extends NetworkRepository {
  final _bannerApi = locator<BannerApi>();

  RepoListResult<BannerModel> getBanners(PaginationDto dto) {
    return tryApiCall(() async {
      final response = await _bannerApi.getBanners(dto.toJson());
      return PaginationResult.fromResponse(
        response: response,
        fromJson: BannerModel.fromJson,
      );
    });
  }

  RepoResult<BannerModel> getBanner(String id) {
    return tryApiCall(() async {
      final response = await _bannerApi.getBanner(id);
      return BannerModel.fromJson(response.data!);
    });
  }

  RepoResult<BannerModel> createBanner(CreateBannerDto dto) {
    return tryApiCall(() async {
      final response = await _bannerApi.createBanner(
        await dto.toMap(),
      );
      return BannerModel.fromJson(response.data!);
    });
  }

  RepoResult<BannerModel> updateBanner(UpdateBannerDto dto) {
    return tryApiCall(() async {
      final response = await _bannerApi.updateBanner(
        dto.id,
        await dto.toMap(),
      );
      return BannerModel.fromJson(response.data!);
    });
  }

  RepoResult<void> deleteBanner(BannerModel banner) {
    return tryApiCall(
      () async => await _bannerApi.deleteBanner(banner.id!),
    );
  }
}
