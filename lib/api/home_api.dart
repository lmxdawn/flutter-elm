import 'package:flutter_elm/exception/json_exception.dart';
import 'package:flutter_elm/model/banner_model.dart';
import 'package:flutter_elm/utils/dio_util.dart';
import 'package:flutter_elm/utils/network_file_util.dart';
import 'package:dio/dio.dart';

class HomeApi {
  // 获取首页banner列表
  static Future<List<BannerModel>> banners() async {
    var dio = DioUtil.http();
    try {
      Response<Map<String, dynamic>> response =
          await dio.get("/banners_consumer.json");

      var data = response.data;
      if (data['s'] != 1) {
        throw JsonException(data['s'], data['m']);
      }

      List<BannerModel> bannerList = (data['d'] as List).map((i) {
        BannerModel bannerModel = BannerModel.fromJson(i);
        bannerModel.imageHash = NetworkFileUtil.imageUrl(bannerModel.imageHash);

        return bannerModel;
      }).toList();
      return bannerList;
    } on JsonException catch (e) {
      throw JsonException(e.code, e.message);
    } catch (e) {
      throw JsonException(-1, e.toString());
    }
  }
}
