// ignore_for_file: library_private_types_in_public_api

part of 'auctions_cubit.dart';

enum _AuctionsStatus { initial, loading, loaded, error }

class AuctionsState extends ErrorState {
  final List<AuctionModel> auctions;
  final _AuctionsStatus _status;

  AuctionsState({
    required this.auctions,
    _AuctionsStatus status = _AuctionsStatus.initial,
    String? error,
  }) : _status = status,
       super(error);

  bool get isLoading => _status == _AuctionsStatus.loading;

  factory AuctionsState.initial() => AuctionsState(auctions: []);

  AuctionsState _loading() =>
      _copyWith(status: _AuctionsStatus.loading);

  AuctionsState _loaded(List<AuctionModel> auctions) {
    return _copyWith(
      auctions: this.auctions.withAllUnique(auctions),
      status: _AuctionsStatus.loaded,
    );
  }

  AuctionsState _add(AuctionModel auction) {
    return _copyWith(
      auctions: auctions.withUnique(auction),
      status: _AuctionsStatus.loaded,
    );
  }

  AuctionsState _remove(AuctionModel auction) {
    return _copyWith(
      auctions: auctions.without(auction),
      status: _AuctionsStatus.loaded,
    );
  }

  AuctionsState _replace(AuctionModel auction) {
    return _copyWith(
      auctions: auctions.withReplace(auction),
      status: _AuctionsStatus.loaded,
    );
  }

  AuctionsState _error(String error) =>
      _copyWith(status: _AuctionsStatus.error, error: error);

  AuctionsState _copyWith({
    List<AuctionModel>? auctions,
    _AuctionsStatus? status,
    String? error,
  }) {
    return AuctionsState(
      auctions: auctions ?? this.auctions,
      status: status ?? _status,
      error: error,
    );
  }
}
