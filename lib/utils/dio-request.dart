import 'package:dio/dio.dart';

import 'commons.dart';

BaseOptions options = BaseOptions(
  baseUrl: Commons.movieBaseUrl,
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio movieDio = Dio(options);
