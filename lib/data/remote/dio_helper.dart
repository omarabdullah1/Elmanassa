
import 'dart:io';

import 'package:dio/dio.dart';

import '../../constants/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> getDataWithToken({
    required String url,
    Map<String, dynamic>? query,
    required String token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dio!.post(
      url,
      data: body,
      // options: Options(headers: {
      //   HttpHeaders.contentTypeHeader: "application/json",
      //   HttpHeaders.acceptHeader: 'application/json',
      // }),
    );
  }
  static Future<Response> postDataWithToken({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
    required String token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return await dio!.post(
      url,
      data: body,
      // options: Options(headers: {
      //   HttpHeaders.contentTypeHeader: "application/json",
      //   HttpHeaders.acceptHeader: 'application/json',
      // }),
    );
  }
  static Future<Response> putDataWithToken({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
    required String token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return await dio!.put(
      url,
      data: body,
      // options: Options(headers: {
      //   HttpHeaders.contentTypeHeader: "application/json",
      //   HttpHeaders.acceptHeader: 'application/json',
      // }),
    );
  }

  static Future<Response> postDataWithTokenAndFiles({
    required String url,
    Map<String, dynamic>? query,
    required FormData body,
    required String token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return await dio!.post(
      url,
      data: body,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: 'application/json',
      }),
    );
  }
}
