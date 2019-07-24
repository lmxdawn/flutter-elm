// 网络文件操作类
import 'package:flutter_elm/config/application.dart';

class ImageUtil {
  // 组装图片的网络地址
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
