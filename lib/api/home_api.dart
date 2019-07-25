import 'package:flutter_elm/exception/exception_json.dart';
import 'package:flutter_elm/model/banner_model.dart';
import 'package:flutter_elm/utils/dio_util.dart';
import 'package:flutter_elm/utils/network_file_util.dart';
import 'package:dio/dio.dart';

// 获取首页banner列表
Future<List<BannerModel>> banners() async {
  var dio = DioUtil.http();
  Response<Map<String, dynamic>> response =
      await dio.get("/banners_consumer.json");

  try{
  var data = response.data;
  if (data['s'] != 1) {
    throw ExceptionJson(data['s'], data['m']);
  }

  List<BannerModel> bannerList = (data['d'] as List).map((i) {
    BannerModel bannerModel = BannerModel.fromJson(i);
    bannerModel.imageHash = NetworkFileUtil.imageUrl(bannerModel.imageHash);
    
    return bannerModel;
  }).toList();
  return bannerList;
  }catch(e) {
    throw ExceptionJson(-1, e.toString());
  }

}
