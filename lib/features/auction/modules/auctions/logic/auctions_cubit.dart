import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/extension/list.extension.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';
import 'package:mazad_app/features/auction/data/repository/auction_repo.dart';

part 'auctions_state.dart';

class AuctionsCubit extends Cubit<AuctionsState> {
  final _auctionRepo = locator<AuctionRepo>();
  final _paginationDto = PaginationDto();
  AuctionsCubit() : super(AuctionsState.initial());

  PaginationDto get filterDto => _paginationDto;

  void loadNew() {
    _paginationDto.firstPage();
    state.auctions.clear();
    load();
  }

  void load() async {
    emit(state._loading());

    final result = await _auctionRepo.getAuctions(_paginationDto);

    result.when(
      success: (result) {
        final auctions = result.data;

        if (auctions.isNotEmpty) _paginationDto.nextPage();

        emit(state._loaded(auctions));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void add(AuctionModel auction) => emit(state._add(auction));

  void remove(AuctionModel auction) async {
    final result = await _auctionRepo.deleteAuction(auction);

    result.when(
      success: (_) => emit(state._remove(auction)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void update(AuctionModel auction) => emit(state._replace(auction));
}
