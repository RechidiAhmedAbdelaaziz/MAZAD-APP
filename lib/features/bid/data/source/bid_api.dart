import 'package:dio/dio.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';
import 'package:retrofit/retrofit.dart';

part 'bid_api.g.dart';

@RestApi()
abstract class BidApi {
  factory BidApi(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _BidApi;

  @GET('/bids/product/{productId}')
  Future<PaginatedDataResponse> getBids(
    @Path('productId') String productId,
    @Body() Map<String, dynamic> body,
  );

  @GET('/bids/{bidId}')
  Future<SingleDataResponse> getBid(@Path('bidId') String bidId);

  @POST('/bids/{productId}')
  Future<SingleDataResponse> createBid(
    @Path('productId') String productId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/bids/{bidId}')
  Future<SingleDataResponse> updateBid(
    @Path('bidId') String bidId,
    @Body() Map<String, dynamic> body,
  );
}
