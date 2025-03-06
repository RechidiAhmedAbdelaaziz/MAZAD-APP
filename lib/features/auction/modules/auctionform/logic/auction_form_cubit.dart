import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/auction/data/dto/auction_dto.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';
import 'package:mazad_app/features/auction/data/repository/auction_repo.dart';

part 'auction_form_state.dart';

class AuctionFormCubit extends Cubit<AuctionFormState> {
  final _auctionRepo = locator<AuctionRepo>();
  AuctionFormCubit() : super(AuctionFormState.initial());

  void loadDto([String? id]) async {
    emit(state._loading());

    if (id == null) return emit(state._loaded(CreateAuctionDto()));

    final result = await _auctionRepo.getAuction(id);

    result.when(
      success:
          (auction) => emit(state._loaded(UpdateAuctionDto(auction))),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void save() async {
    final dto = state.dto;

    if (!dto.validate()) return;

    final result =
        dto.isNew
            ? await _auctionRepo.createAuction(
              dto as CreateAuctionDto,
            )
            : await _auctionRepo.updateAuction(
              dto as UpdateAuctionDto,
            );

    result.when(
      success: (auction) => emit(state._saved(auction)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  @override
  Future<void> close() {
    state._dto?.dispose();
    return super.close();
  }
}
