import 'package:flutter_elm/config/config.dart';

// 本地测试
class AppDev extends Config {
  @override
  String get networkImageBaseUrl => "https://raw.githubusercontent.com/lmxdawn/flutter-elm/master/elm-image/";
  @override
  String get httpBaseUrl => "https://raw.githubusercontent.com/lmxdawn/flutter-elm/master/elm-json";
}