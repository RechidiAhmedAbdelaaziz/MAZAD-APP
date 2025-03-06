// ignore_for_file: library_private_types_in_public_api

part of 'products_cubit.dart';

enum _ProductsStatus { initial, loading, loaded, error }

class ProductsState extends ErrorState {
  final List<ProductModel> products;
  final _ProductsStatus status;

  ProductsState({
    required this.products,
    this.status = _ProductsStatus.initial,
    String? error,
  }) : super(error);

  factory ProductsState.initial() => ProductsState(products: []);

  bool get isLoading => status == _ProductsStatus.loading;

  ProductsState _loading() =>
      _copyWith(status: _ProductsStatus.loading);

  ProductsState _loaded(List<ProductModel> newProducts) {
    return _copyWith(
      products: products.withAllUnique(newProducts),
      status: _ProductsStatus.loaded,
    );
  }

  ProductsState _addProduct(ProductModel product) {
    return _copyWith(
      products: products.withUnique(product),
      status: _ProductsStatus.loaded,
    );
  }

  ProductsState _removeProduct(ProductModel product) {
    return _copyWith(
      products: products.without(product),
      status: _ProductsStatus.loaded,
    );
  }

  ProductsState _updateProduct(ProductModel product) {
    return _copyWith(
      products: products.withReplace(product),
      status: _ProductsStatus.loaded,
    );
  }

  ProductsState _error(String error) =>
      _copyWith(status: _ProductsStatus.error, error: error);

  ProductsState _copyWith({
    List<ProductModel>? products,
    _ProductsStatus? status,
    String? error,
  }) {
    return ProductsState(
      products: products ?? this.products,
      status: status ?? this.status,
      error: error,
    );
  }
}
