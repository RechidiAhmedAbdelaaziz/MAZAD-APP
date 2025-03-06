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
}
