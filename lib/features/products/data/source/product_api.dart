import 'package:dio/dio.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api.g.dart';

@RestApi()
abstract class ProductApi {
  factory ProductApi(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _ProductApi;


  @GET('/products/auction/{auctionId}') //* GET ALL ~ {{URL}}/products/:auctionId
  Future<PaginatedDataResponse> getProducts(
    @Path('auctionId') String auctionId,
    @Queries() Map<String, dynamic> query,
  );

  @GET('/products/{id}') //* GET ONE ~ {{URL}}/products/:id
  Future<SingleDataResponse> getProduct(
    @Path('id') String id,
  );
 
  @POST('/products') //* CREATE  ~ {{URL}}/products
  Future<SingleDataResponse> createProduct(
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/products/{id}') //* UPDATE  ~ {{URL}}/products/:id
  Future<SingleDataResponse> updateProduct(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/products/{id}') //* DELETE  ~ {{URL}}/products/:id
  Future<MessageResponse> deleteProduct(
    @Path('id') String id,
  );
}
