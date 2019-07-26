import 'package:flutter_elm/exception/json_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elm/api/home_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_elm/model/banner_model.dart';
import 'package:flutter_elm/pages/test_page.dart';
import 'package:flutter_elm/utils/custom_route_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerModel> _bannerModelList;

  // APP Bar 透明度
  double appBarAlpha = 0;
  // 最大滚动到多少变可见
  static const APPBAR_SCROLL_OFFSET = 100;

  @override
  void initState() {
    // 初始化数据
    _loadData();
    super.initState();
  }

// 加载初始化数据
  _loadData() async {
    // 顶部banner数据
    try {
      List<BannerModel> bannerList = await HomeApi.banners();
      setState(() {
        _bannerModelList = bannerList;
      });
    } on JsonException catch (e) {
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
              // 滚动触发
              onNotification: (scrollNotification) {
                // 列表滚动
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: _listView(),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("首页"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 列表数据
  Widget _listView() {
    return ListView(
      children: <Widget>[
        Container(
          height: 160,
          child: _bannerView(),
        ),
        Container(
          height: 800,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(CustomRouteUtil.slide(
                  SecondPage(
                    title: "哈哈哈哈哈哈",
                  ),
                  milliseconds: 300));
            },
            child: ListTile(
              title: Text("嘿嘿"),
            ),
          ),
        )
      ],
    );
  }

  // 顶部banner
  Widget _bannerView() {
    return _bannerModelList == null
        ? null
        : Swiper(
            itemCount: _bannerModelList.length,
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
//               return Image.network(
//                   _bannerModelList[index].imageHash,
//                 fit: BoxFit.fill,
//               );
              return CachedNetworkImage(
                imageUrl: _bannerModelList[index].imageHash,
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,),
                      ),
                    ),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            },
            pagination: SwiperPagination(),
          );
  }

  // 页面滚动
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
}
