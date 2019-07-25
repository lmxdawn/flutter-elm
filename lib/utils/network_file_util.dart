// 网络文件操作类
import 'package:flutter_elm/config/Application.dart';


class NetworkFileUtil {
  static String imageUrl(String hash) {
    return isHttp(hash) ? hash : "${Application.config.networkImageBaseUrl}/$hash";
  }
  
  // 判断是否是网络地址
  static bool isHttp(String hash) {
    String http = hash.substring(0, 1);
    if (http == "/") {
      return true;
    } else if (hash.substring(0, 1) == "http") {
      return true;
    }
    return false;
  }
}
