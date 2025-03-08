// ignore_for_file: library_private_types_in_public_api

part of 'profile_cubit.dart';

enum _ProfileStatus { initial, loading, loaded, saved, error }

class ProfileState<T extends UserDto> extends ErrorState {
  final T? _dto;
  final _ProfileStatus _status;

  ProfileState({
    T? dto,
    _ProfileStatus status = _ProfileStatus.initial,
    String? error,
  }) : _dto = dto,
       _status = status,
       super(error);

  bool get isLoading => _status == _ProfileStatus.loading;
  bool get isLoaded => _dto != null;
  T get dto => _dto!;

  ProfileState<T> _loading() =>
      _copyWith(status: _ProfileStatus.loading);

  ProfileState<T> _loaded(T dto) =>
      _copyWith(dto: dto, status: _ProfileStatus.loaded);

  ProfileState<T> _saved() => _copyWith(status: _ProfileStatus.saved);

  ProfileState<T> _error(String error) =>
      _copyWith(error: error, status: _ProfileStatus.error);

  ProfileState<T> _copyWith({
    T? dto,
    _ProfileStatus? status,
    String? error,
  }) {
    return ProfileState(
      dto: dto ?? _dto,
      status: status ?? _status,
      error: error,
    );
  }

  void onSaved(VoidCallback callback) {
    if (_status == _ProfileStatus.saved) {
      callback();
    }
  }
}
