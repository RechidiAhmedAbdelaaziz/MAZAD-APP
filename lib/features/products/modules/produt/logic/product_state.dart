// ignore_for_file: library_private_types_in_public_api

part of 'product_cubit.dart';

enum _ProductStatus { initial, loading, loaded, saved, error }

class ProductState extends ErrorState {
  final ProductModel? _dto;
  final _ProductStatus _status;

  ProductState({
    ProductModel? dto,
    _ProductStatus status = _ProductStatus.initial,
    String? error,
  }) : _status = status,
       _dto = dto,
       super(error);

  bool get isLoading => _status == _ProductStatus.loading;
  bool get isLoaded => _dto != null;

  ProductModel get product => _dto!;

  factory ProductState.initial() => ProductState();

  ProductState _loading() =>
      _copyWith(status: _ProductStatus.loading);

  ProductState _loaded(ProductModel dto) =>
      _copyWith(dto: dto, status: _ProductStatus.loaded);


  ProductState _error(String error) =>
      _copyWith(error: error, status: _ProductStatus.error);

  ProductState _copyWith({
    ProductModel? dto,
    _ProductStatus? status,
    String? error,
  }) {
    return ProductState(
      dto: dto ?? _dto,
      status: status ?? _status,
      error: error,
    );
  }

  void onSave(ValueChanged<ProductModel> callback) {}
}
