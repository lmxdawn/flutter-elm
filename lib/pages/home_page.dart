import 'package:flutter_elm/exception/json_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elm/api/home_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_elm/model/banner_model.dart';
import 'package:flutter_elm/pages/address_page.dart';
import 'package:flutter_elm/utils/custom_route_util.dart';
import 'package:flutter_elm/widget/loading_container.dart';
import 'package:flutter_elm/widget/loading_view.dart';
import 'package:flutter_elm/widget/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<BannerModel> _bannerModelList;

  // APP Bar 透明度
  double _appBarAlpha = 1;
  // 是否滚动到 搜索框
  bool _isSearchPosition = false;
  // padding
  EdgeInsets _padding;

  // 是否显示加载
  bool _loading = true;

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
      Toast.show(context, "加载完成");
      setState(() {
        _bannerModelList = bannerList;
        _loading = false;
      });
    } on JsonException catch (e) {
      print(e.code);
      _loading = false;
    }
  }

  // 页面滚动
  _onScroll(offset) {
    double alpha = offset / (ScreenUtil().setWidth(80));
    if (alpha <= 0) {
      alpha = 1;
    } else if (alpha >= 1) {
      alpha = 0;
    } else {
      alpha = 1 - alpha;
    }

    bool isSearchPosition = false;
    if (offset > ScreenUtil().setWidth(100)) {
      isSearchPosition = true;
    }

    setState(() {
      _appBarAlpha = alpha;
      _isSearchPosition = isSearchPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取手机周边区域
    _padding = MediaQuery.of(context).padding;
    // 屏幕适配
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: LoadingContainer(
        loading: _loading,
        backgroundColor: Colors.white,
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Stack(
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
          // 浮动的搜索框
          _stackTopSearch()
        ],
      ),
    );
  }

  // 浮动的搜索框
  Widget _stackTopSearch() {
    return _isSearchPosition
        ? Container(
            height: ScreenUtil().setWidth(110) + _padding.top,
            padding: EdgeInsets.only(top: _padding.top),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: _topSearch(),
          )
        : Container(
            child: null,
          );
  }

  // 列表数据
  Widget _listView() {
    return ListView(
      children: <Widget>[
        Container(height: _padding.top),
        _topBar(),
        _topSearch(),
        _bannerView(),
        Container(
          height: 800,
          child: InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("嘿嘿"),
            ),
          ),
        )
      ],
    );
  }

  // 顶部
  Widget _topBar() {
    Color blue = Colors.blue;
    var height = ScreenUtil().setWidth(100);
    return Opacity(
      opacity: _appBarAlpha,
      child: Container(
        height: height,
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // 跳转到选择收获地址页面
                  Navigator.of(context).push(
                      CustomRouteUtil.slide(AddressPage(), milliseconds: 300));
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Colors.blue,
                    ),
                    Text(
                      "江川二村北区",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black26,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.fullscreen,
                  color: blue,
                ),
                Text(
                  "扫码",
                  style: TextStyle(color: blue),
                )
              ],
            ),
            Container(
              width: 20,
              child: null,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.filter_drama,
                  color: blue,
                ),
                Container(
                  width: 5,
                  child: null,
                ),
                Text(
                  "31℃",
                  style: TextStyle(color: blue),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // 顶部搜索框
  Widget _topSearch() {
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

  // 顶部banner
  Widget _bannerView() {
    final double height = ScreenUtil().setWidth(170);
    return _bannerModelList == null
        ? LoadingView(height: height)
        : Container(
            decoration: BoxDecoration(),
            height: height,
            child: PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4.0),
              clipBehavior: Clip.antiAlias,
              child: Swiper(
                itemCount: _bannerModelList.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
//               return Image.network(
//                   _bannerModelList[index].imageHash,
//                 fit: BoxFit.fill,
//               );
                  // 图片懒加载
                  return CachedNetworkImage(
                    imageUrl: _bannerModelList[index].imageHash,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => LoadingView(height: height),
                    errorWidget: (context, url, error) =>
                        LoadingView(text: "加载失败", height: height),
                  );
                },
                pagination: SwiperPagination(),
              ),
            ),
          );
  }

  // 让 TabBarView 和 PageView 的页面切换时存活
  @override
  bool get wantKeepAlive => true;
}
