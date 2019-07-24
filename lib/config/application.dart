import 'package:flutter_elm/config/config.dart';
import 'package:flutter_elm/config/config_build.dart';
import 'package:flutter_elm/config/config_dev.dart';
import 'package:flutter_elm/config/config_stage.dart';

enum Env {
  BUILD, // 正式环境
  STAGE, // 线上测试
  DEV,   // 本地测试
}

class Application {
  static Env env;
  static Config config;
  static void init(Env env) {
    env = env;
    switch (env) {
      case Env.BUILD:
        config = AppBuild();
        break;
      case Env.STAGE:
        config = AppStage();
        break;
      case Env.DEV:
      default:
        config = AppDev();
    }
  }
}