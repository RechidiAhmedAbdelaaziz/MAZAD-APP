// ignore_for_file: library_private_types_in_public_api

part of 'bids_cubit.dart';

enum _BidsStatus { initial, loading, loaded, error }

class BidsState extends ErrorState {
  final List<BidModel> bids;
  final _BidsStatus _status;

  BidsState({
    required this.bids,
    _BidsStatus status = _BidsStatus.initial,
    String? error,
  }) : _status = status,
       super(error);

  bool get isLoading => _status == _BidsStatus.loading;

  factory BidsState.initial() => BidsState(
    bids: [
      BidModel(
        quantity: 12,
        amount: 1000,
        user: UserModel(
          name: "Rechidi",
          phone: "0555555555",
          region: 'Oran',
        ),
      ),
    ],
  );

  BidsState _loading() => _copyWith(status: _BidsStatus.loading);

  BidsState _loaded(List<BidModel> bids) {
    return _copyWith(
      bids: this.bids.withAllUnique(bids),
      status: _BidsStatus.loaded,
    );
  }

  BidsState _error(String error) =>
      _copyWith(error: error, status: _BidsStatus.error);

  BidsState _copyWith({
    List<BidModel>? bids,
    _BidsStatus? status,
    String? error,
  }) {
    return BidsState(
      bids: bids ?? this.bids,
      status: status ?? _status,
      error: error,
    );
  }
}
