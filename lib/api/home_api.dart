import 'package:flutter_elm/utils/dio_util.dart';
import 'package:dio/dio.dart';

// 获取首页banner列表
Future banners() async {
  var dio = DioUtil.http();
  Response<Map<String, dynamic>> response =
      await dio.get("/banners_consumer.json");
  return response.data;
}
