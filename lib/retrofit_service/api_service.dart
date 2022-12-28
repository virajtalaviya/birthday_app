import 'package:birthday_app/retrofit_service/model/gif/gif_model.dart';
import 'package:birthday_app/retrofit_service/model/image/image_model.dart';
import 'package:birthday_app/retrofit_service/model/quotes/quotes_model.dart';
import 'package:birthday_app/retrofit_service/model/songs/songs_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://fs-hr-bs.herokuapp.com/api/birthday/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("image/list")
  Future<ImageModel> getImages();

  @GET("song/list")
  Future<SongsModel> getSongs();

  @GET("quotes/list")
  Future<QuotesModel> getQuotes();

  @GET("GIF/list")
  Future<GIFModel> getGIF();
}
