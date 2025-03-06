// ignore_for_file: library_private_types_in_public_api

part of 'banner_cubit.dart';

enum _BannerStatus { initial, loading, loaded, saved, error }

class BannerState extends ErrorState {
  final BannerDto? _dto;
  final _BannerStatus _status;

  BannerState({
    BannerDto? dto,
    _BannerStatus status = _BannerStatus.initial,
    String? error,
  }) : _dto = dto,
       _status = status,
       super(error);

  factory BannerState.initial() => BannerState();

  bool get isLoading => _status == _BannerStatus.loading;
  bool get isLoaded => _dto != null;

  BannerDto get dto => _dto!;

  BannerState _loading() => _copyWith(status: _BannerStatus.loading);

  BannerState _loaded(BannerDto dto) =>
      _copyWith(dto: dto, status: _BannerStatus.loaded);

  BannerState _saved(BannerModel banner) =>
      _SavedBannerState(banner, this);

  BannerState _error(String error) =>
      _copyWith(error: error, status: _BannerStatus.error);

  BannerState _copyWith({
    BannerDto? dto,
    _BannerStatus? status,
    String? error,
  }) {
    return BannerState(
      dto: dto ?? _dto,
      status: status ?? _status,
      error: error,
    );
  }

  void onSave(ValueChanged<BannerModel> callback) {}
}

class _SavedBannerState extends BannerState {
  final BannerModel _banner;

  _SavedBannerState(this._banner, BannerState state)
    : super(dto: state._dto, status: _BannerStatus.saved);

  @override
  void onSave(ValueChanged<BannerModel> callback) =>
      callback(_banner);
}
