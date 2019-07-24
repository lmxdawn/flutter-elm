import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/**
 * 路由操作类
 */
class CustomRouteUtil {
  /**
   * iOS 的右滑返回上一页的路由
   */
  static CupertinoPageRoute cupertino(Widget page) {
    return CupertinoPageRoute(builder: (BuildContext context) {
      return page;
    });
  }

  /**
   * 普通的路由
   */
  static MaterialPageRoute material(Widget page) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return page;
    });
  }

  /**
   * 幻灯片式的路由 （默认是从下往上）
   */
  static PageRouteBuilder slide(Widget page,
      {int milliseconds = 1000,
      double top = 1.0,
      double left = 0.0,
      double bottom = 0.0,
      double right = 0.0}) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: milliseconds),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
                  begin: Offset(left, top), end: Offset(right, bottom))
              .animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
