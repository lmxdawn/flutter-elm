import 'package:flutter_elm/config/config.dart';

// 线上测试
class AppStage extends Config {
  @override
  String get networkImageBaseUrl => "https://raw.githubusercontent.com/lmxdawn/flutter-elm/master/elm-image/";
  @override
  String get httpBaseUrl => "https://raw.githubusercontent.com/lmxdawn/flutter-elm/master/elm-json";
}