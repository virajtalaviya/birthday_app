// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'api_service.dart';
//
// // **************************************************************************
// // RetrofitGenerator
// // **************************************************************************
//
// // ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers
//
// class _ApiClient implements ApiClient {
//   _ApiClient(this._dio, {this.baseUrl}) {
//     baseUrl ??= 'https://fs-hr-bs.herokuapp.com/api/birthday/';
//   }
//
//   final Dio _dio;
//
//   String? baseUrl;
//
//   @override
//   Future<ImageModel> getImages() async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     final _result = await _dio.fetch<Map<String, dynamic>>(
//         _setStreamType<ImageModel>(
//             Options(method: 'GET', headers: _headers, extra: _extra)
//                 .compose(_dio.options, 'image/list',
//                     queryParameters: queryParameters, data: _data)
//                 .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
//     final value = ImageModel.fromJson(_result.data!);
//     return value;
//   }
//
//   @override
//   Future<SongsModel> getSongs() async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     final _result = await _dio.fetch<Map<String, dynamic>>(
//         _setStreamType<SongsModel>(
//             Options(method: 'GET', headers: _headers, extra: _extra)
//                 .compose(_dio.options, 'song/list',
//                     queryParameters: queryParameters, data: _data)
//                 .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
//     final value = SongsModel.fromJson(_result.data!);
//     return value;
//   }
//
//   @override
//   Future<QuotesModel> getQuotes() async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     final _result = await _dio.fetch<Map<String, dynamic>>(
//         _setStreamType<QuotesModel>(
//             Options(method: 'GET', headers: _headers, extra: _extra)
//                 .compose(_dio.options, 'quotes/list',
//                     queryParameters: queryParameters, data: _data)
//                 .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
//     final value = QuotesModel.fromJson(_result.data!);
//     return value;
//   }
//
//   @override
//   Future<GIFModel> getGIF() async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     final _result = await _dio.fetch<Map<String, dynamic>>(
//         _setStreamType<GIFModel>(
//             Options(method: 'GET', headers: _headers, extra: _extra)
//                 .compose(_dio.options, 'GIF/list',
//                     queryParameters: queryParameters, data: _data)
//                 .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
//     final value = GIFModel.fromJson(_result.data!);
//     return value;
//   }
//
//   RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
//     if (T != dynamic &&
//         !(requestOptions.responseType == ResponseType.bytes ||
//             requestOptions.responseType == ResponseType.stream)) {
//       if (T == String) {
//         requestOptions.responseType = ResponseType.plain;
//       } else {
//         requestOptions.responseType = ResponseType.json;
//       }
//     }
//     return requestOptions;
//   }
// }
