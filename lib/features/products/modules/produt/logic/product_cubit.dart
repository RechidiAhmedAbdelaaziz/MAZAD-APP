import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';
import 'package:mazad_app/features/products/data/repository/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final _productRepo = locator<ProductRepo>();

  ProductCubit() : super(ProductState.initial());

  void loadProduct(String id) async {
    emit(state._loading());

    final result = await _productRepo.getProduct(id);

    result.when(
      success: (product) => emit(state._loaded(product)),
      error: (error) => emit(state._error(error.message)),
    );
  }
}
