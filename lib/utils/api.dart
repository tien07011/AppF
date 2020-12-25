import 'dart:async';
import 'dart:io';

import 'package:app_tv/app/app.module.dart';
import 'package:app_tv/routers/application.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class API {
  static String baseUrl = "http://api.tvclubuet.com";
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      contentType: 'application/json; charset=utf-8',
      baseUrl: baseUrl,
      // baseUrl: "http://api.tvclubuet.com"
    ),
  );

  API() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
//    dio.interceptors
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      Application.sharePreference.hasKey("token")
          ? options.headers["token"] = "${Application.sharePreference.getString("token")}"
          : {};
      print(options.uri);
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      if (response?.data['status'] == 401) {
        Application.sharePreference.clear().whenComplete(() => Modular.to.pushNamedAndRemoveUntil("/login", ModalRoute.withName(Modular.initialRoute)));
      }
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      // Refresh Token

      return e.response; //continue
    }));
  }

  Future get(String url, [Map<String, dynamic> params]) async {
    return dio.get(url, queryParameters: params);
  }

  Future post(String url, Map<String, dynamic> params) async {
    return dio.post(url, data: params);
  }

  Future put(String url, [Map<String, dynamic> params]) async {
    return dio.put(url, data: params);
  }

  Future delete(String url, [Map<String, dynamic> params]) async {
    return dio.delete(url, queryParameters: params);
  }
}
