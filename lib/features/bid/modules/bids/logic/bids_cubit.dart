import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/extension/list.extension.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/bid/data/model/bid_model.dart';
import 'package:mazad_app/features/bid/data/repository/bid_repo.dart';
import 'package:mazad_app/features/user/source/model/user_model.dart';

part 'bids_state.dart';

class BidsCubit extends Cubit<BidsState> {
  final _bidRepo = locator<BidRepo>();
  final _paginationDto = PaginationDto();
  final String _productId;

  BidsCubit(this._productId) : super(BidsState.initial());

  void getBids() async {
    emit(state._loading());
    final result = await _bidRepo.getBids(_productId, _paginationDto);

    result.when(
      success: (result) {
        final bids = result.data;

        if (bids.isNotEmpty) _paginationDto.nextPage();

        emit(state._loaded(bids));
      },
      error: (error) {
        emit(state._error(error.message));
      },
    );
  }
}
