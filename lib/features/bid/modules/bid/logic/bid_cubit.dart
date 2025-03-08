import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/bid/data/dto/bid_dto.dart';
import 'package:mazad_app/features/bid/data/repository/bid_repo.dart';

part 'bid_state.dart';

class BidCubit extends Cubit<BidState> {
  final _bidRepo = locator<BidRepo>();
  final String _productId;
  final int _price;

  BidCubit(this._productId, {int price = 0})
    : _price = price,
      super(BidState.initial());

  void loadDto() async {
    emit(state._loading());

    final result = await _bidRepo.getBid(_productId);

    result.when(
      success: (bid) => emit(state._loaded(UpdateBidDto(bid))),
      error: (_) => emit(state._loaded(CreateBidDto(_price))),
    );
  }

  void saveBid() async {
    emit(state._loading());

    final result =
        await (state.bidDto is CreateBidDto
            ? _bidRepo.createBid(
              _productId,
              state.bidDto as CreateBidDto,
            )
            : _bidRepo.updateBid(state.bidDto as UpdateBidDto));

    result.when(
      success: (_) => emit(state._saved()),
      error: (error) => emit(state._error(error.message)),
    );
  }
}
