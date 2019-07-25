import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_elm/config/Application.dart';

// 格式化
parseJson(String text) {
  return compute(jsonDecode, text);
}

class DioUtil {
  static Dio http() {
    BaseOptions options = BaseOptions();
    options.baseUrl = Application.config.httpBaseUrl;
    options.connectTimeout = 5000; // 5S
    options.receiveTimeout = 3000;
    options.validateStatus = (int status) {
      return status == HttpStatus.ok || status == HttpStatus.created;
    };
    var dio = Dio(options);
    // 使用 compute 来解析 json 数据，防止解析的时候 UI 卡顿
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    return dio;
  }
}