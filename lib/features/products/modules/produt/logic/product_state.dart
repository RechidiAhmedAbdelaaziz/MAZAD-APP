// ignore_for_file: library_private_types_in_public_api

part of 'product_cubit.dart';

enum _ProductStatus { initial, loading, loaded, saved, error }

class ProductState extends ErrorState {
  final ProductDto? _dto;
  final _ProductStatus _status;

  ProductState({
    ProductDto? dto,
    _ProductStatus status = _ProductStatus.initial,
    String? error,
  }) : _status = status,
       _dto = dto,
       super(error);

  bool get isLoading => _status == _ProductStatus.loading;
  bool get isLoaded => _dto != null;

  ProductDto get dto => _dto!;

  factory ProductState.initial() => ProductState();

  ProductState _loading() =>
      _copyWith(status: _ProductStatus.loading);

  ProductState _loaded(ProductDto dto) =>
      _copyWith(dto: dto, status: _ProductStatus.loaded);

  ProductState _saved(ProductModel product) =>
      _SavedProductState(product, this);

  ProductState _error(String error) =>
      _copyWith(error: error, status: _ProductStatus.error);

  ProductState _copyWith({
    ProductDto? dto,
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

class _SavedProductState extends ProductState {
  final ProductModel _product;

  _SavedProductState(this._product, ProductState state)
    : super(dto: state._dto, status: _ProductStatus.saved);

  @override
  void onSave(ValueChanged<ProductModel> callback) =>
      callback(_product);
}
