// ignore_for_file: library_private_types_in_public_api

part of 'banners_cubit.dart';

enum _BannersStatus { initial, loading, loaded, error }

class BannersState extends ErrorState {
  final List<BannerModel> banners;
  final _BannersStatus _status;

  BannersState({
    required this.banners,
    _BannersStatus status = _BannersStatus.initial,
    String? error,
  }) : _status = status,
       super(error);

  bool get isLoading => _status == _BannersStatus.loading;

  factory BannersState.initial() => BannersState(banners: []);

  BannersState _loading() =>
      _copyWith(status: _BannersStatus.loading);

  BannersState _loaded(List<BannerModel> newBanners) => _copyWith(
    banners: banners.withAllUnique(newBanners),
    status: _BannersStatus.loaded,
  );

  BannersState _addBanner(BannerModel banner) => _copyWith(
    banners: banners.withUnique(banner),
    status: _BannersStatus.loaded,
  );

  BannersState _removeBanner(BannerModel banner) => _copyWith(
    banners: banners.without(banner),
    status: _BannersStatus.loaded,
  );

  BannersState _updateBanner(BannerModel banner) => _copyWith(
    banners: banners.withReplace(banner),
    status: _BannersStatus.loaded,
  );

  BannersState _error(String error) =>
      _copyWith(error: error, status: _BannersStatus.error);

  BannersState _copyWith({
    List<BannerModel>? banners,
    _BannersStatus? status,
    String? error,
  }) {
    return BannersState(
      banners: banners ?? this.banners,
      status: status ?? _status,
      error: error,
    );
  }
}
