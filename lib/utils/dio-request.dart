import 'package:dio/dio.dart';

import 'commons.dart';

BaseOptions options = BaseOptions(
  baseUrl: Commons.baseUrl,
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = Dio(options);
