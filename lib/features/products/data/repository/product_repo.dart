import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/repo_base.dart';
import 'package:mazad_app/core/network/types/api_result.type.dart';
import 'package:mazad_app/core/shared/dto/pagination/pagination.dto.dart';
import 'package:mazad_app/features/products/data/dto/product_dto.dart';

import '../models/product_model.dart';
import '../source/product_api.dart';

class ProductRepo extends NetworkRepository {
  final _productApi = locator<ProductApi>();

  RepoListResult<ProductModel> getProducts(
    String auctionId,
    PaginationDto query,
  ) => tryApiCall(() async {
    final response = await _productApi.getProducts(
      auctionId,
      query.toJson(),
    );

    return PaginationResult.fromResponse(
      response: response,
      fromJson: ProductModel.fromJson,
    );
  });

  RepoResult<ProductModel> getProduct(String id) =>
      tryApiCall(() async {
        final response = await _productApi.getProduct(id);
        return ProductModel.fromJson(response.data!);
      });

  RepoResult<ProductModel> createProduct(CreateProductDto dto) =>
      tryApiCall(() async {
        final response = await _productApi.createProduct(
          await dto.toMap(),
        );
        return ProductModel.fromJson(response.data!);
      });

  RepoResult<ProductModel> updateProduct(UpdateProductDto dto) =>
      tryApiCall(() async {
        final response = await _productApi.updateProduct(
          dto.id,
          await dto.toMap(),
        );
        return ProductModel.fromJson(response.data!);
      });

  RepoResult<void> deleteProduct(ProductModel product) => tryApiCall(
    () async => await _productApi.deleteProduct(product.id!),
  );
}
