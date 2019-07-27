import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    // 屏幕适配
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: _appBar(context),
      body: _listView(),
    );
  }

  // appBar
  AppBar _appBar(BuildContext context) {
    var fontSize = ScreenUtil().setSp(35);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        padding: EdgeInsets.only(left: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      title: Text(
        "选择收获地址",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
            fontSize: fontSize),
      ),
      actions: <Widget>[
        Center(
          child: Container(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "管理",
                style: TextStyle(color: Colors.blueAccent, fontSize: fontSize),
              ),
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  // 列表
  Widget _listView() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          _search(),
        ],
      ),
    );
  }

  // 顶部搜索框
  Widget _search() {
    final double height = ScreenUtil().setWidth(100);
    final double searchHeight = ScreenUtil().setWidth(60);
    return Container(
      height: height,
      child: Center(
        child: PhysicalModel(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25.0),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: searchHeight,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.grey[600],
                ),
                Text(
                  "搜索",
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
