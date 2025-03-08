// ignore_for_file: library_private_types_in_public_api

part of 'bid_cubit.dart';

enum _BidStatus { initial, loading, loaded, saved, error }

class BidState extends ErrorState {
  final BidDto? _bidDto;
  final _BidStatus _status;

  BidState({
    BidDto? bidDto,
    _BidStatus status = _BidStatus.initial,
    String? error,
  }) : _bidDto = bidDto,
       _status = status,
       super(error);

  bool get isLoading => _status == _BidStatus.loading;
  bool get isLoaded => _bidDto != null;

  BidDto get bidDto => _bidDto!;

  factory BidState.initial() => BidState();

  BidState _loading() => _copyWith(status: _BidStatus.loading);

  BidState _loaded(BidDto bidDto) {
    return _copyWith(bidDto: bidDto, status: _BidStatus.loaded);
  }

  BidState _saved() => _copyWith(status: _BidStatus.saved);

  BidState _error(String error) =>
      _copyWith(error: error, status: _BidStatus.error);

  BidState _copyWith({
    BidDto? bidDto,
    _BidStatus? status,
    String? error,
  }) {
    return BidState(
      bidDto: bidDto ?? _bidDto,
      status: status ?? _status,
      error: error,
    );
  }

  void onSave(Function() back) {
    if (_status == _BidStatus.saved) {
      back();
    }
  }
}
