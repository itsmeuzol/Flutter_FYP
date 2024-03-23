import 'package:dio/dio.dart';
import 'package:finalyear/utils/urls.dart';


class HttpServices {
  static final HttpServices _instances = HttpServices.internal();
  factory HttpServices() => _instances;
  HttpServices.internal();

  Dio? _dio;
  Dio getDioInstance() {
    if (_dio == null) {
      return Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 10000),
        ),
      );
    } else {
      return _dio!;
    }
  }
}
