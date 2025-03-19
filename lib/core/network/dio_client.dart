import 'package:codebase/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    print(path);
    print(queryParameters);
    return await dio.get(path, queryParameters: queryParameters);
  }
}