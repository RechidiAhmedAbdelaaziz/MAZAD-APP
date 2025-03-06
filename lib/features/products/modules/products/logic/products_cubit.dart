import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/extension/list.extension.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';
import 'package:mazad_app/features/products/data/repository/product_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final _productRepo = locator<ProductRepo>();

  final String _auctionId;
  final _pagination = PaginationDto();
  ProductsCubit(this._auctionId) : super(ProductsState.initial());

  void loadProducts() async {
    emit(state._loading());
    final result = await _productRepo.getProducts(
      _auctionId,
      _pagination,
    );
    result.when(
      success: (result) {
        final products = result.data;
        if (products.isNotEmpty) _pagination.nextPage();
        emit(state._loaded(products));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void addProduct(ProductModel product) =>
      emit(state._addProduct(product));

  void removeProduct(ProductModel product) async {
    emit(state._loading());

    final result = await _productRepo.deleteProduct(product);

    result.when(
      success: (_) => emit(state._removeProduct(product)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void updateProduct(ProductModel product) =>
      emit(state._updateProduct(product));
}
