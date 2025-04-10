import 'package:dio/dio.dart';

class DioHelper {

  static Dio? dio;

  static const String rapidApiKey = '95109f84c7msh5e4f5d6189b4185p1e8378jsndc1966219385';

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://exercisedb.p.rapidapi.com/',
        receiveDataWhenStatusError: true,
        headers: {
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
          'X-RapidAPI-Key': rapidApiKey,
        },
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
  }) async {
    dio?.options.headers = {
      'Content-Type' : 'application/json',
    };

    return await dio?.get(
      url,
    );
  }

  // static Future<Response?> postData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  //   String lang = 'en',
  //   String? token,
  // }) async
  // {
  //   dio?.options.headers =
  //   {
  //     'lang':lang,
  //     'Content-Type' : 'application/json',
  //     'Authorization': token,
  //   };
  //
  //   return dio?.post(
  //     url,
  //     queryParameters: query,
  //     data: data,
  //   );
  // }
  //
  // static Future<Response?> putData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  //   String lang = 'en',
  //   String? token,
  // }) async
  // {
  //   dio?.options.headers =
  //   {
  //     'lang':lang,
  //     'Content-Type' : 'application/json',
  //     'Authorization': token,
  //   };
  //
  //   return dio?.put(
  //     url,
  //     queryParameters: query,
  //     data: data,
  //   );
  // }

}