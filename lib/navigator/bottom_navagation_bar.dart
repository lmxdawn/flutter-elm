import 'package:flutter/material.dart';
import 'package:flutter_elm/pages/home_page.dart';
import 'package:flutter_elm/pages/my_page.dart';
import 'package:flutter_elm/pages/search_page.dart';
import 'package:flutter_elm/pages/travel_page.dart';

class BottomNavagationBar extends StatefulWidget {
  @override
  _BottomNavagationBarState createState() => _BottomNavagationBarState();
}

class _BottomNavagationBarState extends State<BottomNavagationBar> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 3);

  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    TravelPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: pages,
        // 禁止滑动
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: _listBarItem(),
      ),
    );
  }

  // 列表
  List<BottomNavigationBarItem> _listBarItem() {
    return [
      _barItem(Icons.home, "首页", 0),
      _barItem(Icons.search, "搜索", 1),
      _barItem(Icons.format_list_bulleted, "订单", 2),
      _barItem(Icons.account_circle, "我的", 3),
    ];
  }

  // 生成底部按钮
  BottomNavigationBarItem _barItem(IconData iconData, String title, int index) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Icon(
        iconData,
        color: _defaultColor,
      ),
      activeIcon: Icon(
        iconData,
        color: _activeColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _currentIndex != index ? _defaultColor : _activeColor,
        ),
      ),
    );
  }
}
