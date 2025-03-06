import 'package:dio/dio.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';
import 'package:retrofit/retrofit.dart';

part 'banner_api.g.dart';

@RestApi()
abstract class BannerApi {
  factory BannerApi(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _BannerApi;
  @GET('/banners') //* GET ALL ~ {{URL}}/banners
  Future<PaginatedDataResponse> getBanners(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/banners/{id}') //* GET ONE ~ {{URL}}/banners/:id
  Future<SingleDataResponse> getBanner(@Path('id') String id);

  @POST('/banners') //* CREATE  ~ {{URL}}/banners
  Future<SingleDataResponse> createBanner(
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/banners/{id}') //* UPDATE  ~ {{URL}}/banners/:id
  Future<SingleDataResponse> updateBanner(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/banners/{id}') //* DELETE  ~ {{URL}}/banners/:id
  Future<MessageResponse> deleteBanner(@Path('id') String id);
}
