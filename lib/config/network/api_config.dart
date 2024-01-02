/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:skybase/config/environment/app_env.dart';
import 'package:skybase/config/network/api_interceptor.dart';
import 'package:skybase/service_locator.dart';

class DioClient {
  static String baseURL = AppEnv.config.baseUrl;
  final Dio _dio = sl<Dio>();

  static Dio get instance => sl<DioClient>()._dio;

  DioClient() {
    _dio.options.baseUrl = baseURL;
    _dio.options.connectTimeout = const Duration(seconds: 60); //60s
    _dio.options.receiveTimeout = const Duration(seconds: 30); //30s
  }

  static void setInterceptor() {
    DioClient.instance.interceptors.clear();
    DioClient.instance.interceptors.add(ApiInterceptors(DioClient.instance));
  }
}
