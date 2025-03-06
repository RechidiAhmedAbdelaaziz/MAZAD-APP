import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/banner/data/dto/banner_dto.dart';
import 'package:mazad_app/features/banner/data/models/banner_model.dart';
import 'package:mazad_app/features/banner/data/repository/banner_repo.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final _bannerRepo = locator<BannerRepo>();
  BannerCubit() : super(BannerState.initial());

  void loadDto([String? id]) async {
    emit(state._loading());

    if (id == null) return emit(state._loaded(CreateBannerDto()));

    final result = await _bannerRepo.getBanner(id);

    result.when(
      success:
          (banner) => emit(state._loaded(UpdateBannerDto(banner))),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void save() async {
    emit(state._loading());

    final dto = state.dto;

    if (!dto.validate()) return;

    final result =
        dto is CreateBannerDto
            ? await _bannerRepo.createBanner(dto)
            : await _bannerRepo.updateBanner(dto as UpdateBannerDto);

    result.when(
      success: (banner) => emit(state._saved(banner)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  @override
  Future<void> close() {
    state._dto?.dispose();
    return super.close();
  }
}
