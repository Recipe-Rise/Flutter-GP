import 'package:dio/dio.dart';

class DioHelper {

  static Dio? dio;
  static Dio? dio2;

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

    dio2 = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:5000/api/',
        receiveDataWhenStatusError: true,
      )
    );

    dio2?.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
    ));

  }


  /*Work out api methods*/

  static Future<Response?> getData({
    required String url,
  }) async {

    // dio?.options.headers = {
    //   'Content-Type' : 'application/json',
    // };

    return await dio?.get(
      url,
    );
  }



  /* our api methods */

  static Future<Response?> getData2({
    required String url,
    Map<String, dynamic>? query,
  }) async {

    dio2?.options.headers = {
      'User-Agent': 'PostmanRuntime/7.43.3',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
    };

    return await dio2?.get(
      url,
      queryParameters: query,
    );
  }




  static Future<Response?> postData2({
    required String url,
    required Map<String, dynamic> data,
  }) async {

    dio2?.options.headers = {
      'User-Agent': 'PostmanRuntime/7.43.3',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Content-Type' : 'multipart/form-data',
    };

    FormData formData = FormData.fromMap(data);

    return await dio2?.post(
      url,
      data: formData,
    );
  }

  static Future<Response?> putData2({
    required String url,
    required Map<String, dynamic> data,
   }) async
   {
    dio2?.options.headers =
     {
       'User-Agent': 'PostmanRuntime/7.43.3',
       'Accept': '*/*',
       'Accept-Encoding': 'gzip, deflate, br',
       'Connection': 'keep-alive',
       'Content-Type': 'application/x-www-form-urlencoded',
     };

    final encodedData = data.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}').join('&');

    print('Encoded Data: $encodedData'); // Debugging

    return await dio2?.put(
       url,
      data: encodedData,
     );
  }


  static Future<Response?> postData_logout({
    required String url,
  }) async {

    dio2?.options.headers = {
      'User-Agent': 'PostmanRuntime/7.43.3',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Content-Type' : 'multipart/form-data',
    };

    return await dio2?.post(
      url,
    );
  }




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


