import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/products/data/dto/product_dto.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';
import 'package:mazad_app/features/products/data/repository/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final _productRepo = locator<ProductRepo>();

  ProductCubit() : super(ProductState.initial());

  void loadDto([String? id]) async {
    emit(state._loading());

    if (id == null) return emit(state._loaded(CreateProductDto()));

    final result = await _productRepo.getProduct(id);

    result.when(
      success:
          (product) => emit(state._loaded(UpdateProductDto(product))),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void save() async {
    emit(state._loading());
    final dto = state.dto;

    if (!dto.validate()) return;

    final result =
        dto is CreateProductDto
            ? await _productRepo.createProduct(dto)
            : await _productRepo.updateProduct(
              dto as UpdateProductDto,
            );

    result.when(
      success: (product) => emit(state._saved(product)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  @override
  Future<void> close() {
    state._dto?.dispose();
    return super.close();
  }
}
