// ignore_for_file: library_private_types_in_public_api

part of 'auction_form_cubit.dart';

enum _AuctionFormStatus { initial, loading, loaded, saved, error }

class AuctionFormState extends ErrorState {
  final AuctionDto? _dto;
  final _AuctionFormStatus _status;

  AuctionFormState({
    AuctionDto? dto,
    _AuctionFormStatus status = _AuctionFormStatus.initial,
    String? error,
  }) : _status = status,
       _dto = dto,
       super(error);

  bool get isLoading => _status == _AuctionFormStatus.loading;
  bool get isLoaded => _dto != null;

  AuctionDto get dto => _dto!;

  factory AuctionFormState.initial() => AuctionFormState();

  AuctionFormState _loading() =>
      _copyWith(status: _AuctionFormStatus.loading);

  AuctionFormState _loaded(AuctionDto dto) =>
      _copyWith(dto: dto, status: _AuctionFormStatus.loaded);

  AuctionFormState _saved(AuctionModel auction) =>
      _SavedAuctionFormState(auction, this);

  AuctionFormState _error(String error) =>
      _copyWith(error: error, status: _AuctionFormStatus.error);

  AuctionFormState _copyWith({
    AuctionDto? dto,
    _AuctionFormStatus? status,
    String? error,
  }) {
    return AuctionFormState(
      dto: dto ?? _dto,
      status: status ?? _status,
      error: error,
    );
  }

  void onSave(ValueChanged<AuctionModel> callback) {}
}

class _SavedAuctionFormState extends AuctionFormState {
  final AuctionModel _auction;

  _SavedAuctionFormState(this._auction, AuctionFormState state)
    : super(dto: state._dto, status: _AuctionFormStatus.saved);

  @override
  void onSave(ValueChanged<AuctionModel> callback) {
    callback(_auction);
  }
}
