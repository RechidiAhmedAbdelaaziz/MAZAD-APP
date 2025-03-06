import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/extension/list.extension.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/banner/data/models/banner_model.dart';
import 'package:mazad_app/features/banner/data/repository/banner_repo.dart';

part 'banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  final _bannerRepo = locator<BannerRepo>();
  final _pagination = PaginationDto();

  BannersCubit() : super(BannersState.initial());

  void getBanners() async {
    emit(state._loading());

    final result = await _bannerRepo.getBanners(_pagination);

    result.when(
      success: (result) {
        final banners = result.data;

        if (banners.isNotEmpty) _pagination.nextPage();

        emit(state._loaded(banners));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void addBanner(BannerModel banner) =>
      emit(state._addBanner(banner));

  void removeBanner(BannerModel banner) async {
    emit(state._loading());

    final result = await _bannerRepo.deleteBanner(banner);

    result.when(
      success: (_) => emit(state._removeBanner(banner)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void updateBanner(BannerModel banner) =>
      emit(state._updateBanner(banner));
}
