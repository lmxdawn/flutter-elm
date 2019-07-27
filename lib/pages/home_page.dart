import 'package:flutter_elm/exception/json_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elm/api/home_api.dart';
import 'package:flutter_elm/model/banner_model.dart';
import 'package:flutter_elm/model/entrie_model.dart';
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
  // 顶部 banner 数据
  List<BannerModel> _bannerModelList;

  // 中心数据
  List<EntrieModel> _entrieList;

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
      setState(() {
        _loading = false;
      });
      print("获取 banner 数据失败: " + e.message);
    }

    // 中心数据
    try {
      List<EntrieModel> entrieList = await HomeApi.entries();
      setState(() {
        _entrieList = entrieList;
      });
    } on JsonException catch (e) {
      print("获取 中心 数据失败: " + e.message);
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
    return Scaffold(
      body: LoadingContainer(
        loading: _loading,
        backgroundColor: Colors.white,
        child: _body(),
      ),
    );
  }

  // padding 10
  Widget _padding10(Widget child) {
    return Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0), child: child);
  }

  Widget _body() {
    return Stack(
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
        _entrieView(),
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
      child: _padding10(
        Container(
          height: height,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // 跳转到选择收获地址页面
                    Navigator.of(context).push(CustomRouteUtil.slide(
                        AddressPage(),
                        milliseconds: 300));
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
      ),
    );
  }

  // 顶部搜索框
  Widget _topSearch() {
    final double height = ScreenUtil().setWidth(100);
    final double searchHeight = ScreenUtil().setWidth(60);
    return _padding10(
      Container(
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
      ),
    );
  }

  // 顶部banner
  Widget _bannerView() {
    final double height = ScreenUtil().setWidth(170);

    if (_bannerModelList == null) {
      return _padding10(LoadingView(height: height));
    }
    return _padding10(
      LoadingView(
        height: height,
        child: PhysicalModel(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          clipBehavior: Clip.antiAlias,
          child: Swiper(
            itemCount: _bannerModelList.length,
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                _bannerModelList[index].imageHash,
                fit: BoxFit.fill,
              );
            },
            pagination: SwiperPagination(
              builder: RectSwiperPaginationBuilder(
                size: Size(18, 7),
                activeSize: Size(18, 7),
                color: Colors.grey[200],
                activeColor: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 中心数据
  Widget _entrieView() {
    final double height = ScreenUtil().setWidth(350);

    if (_entrieList == null) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
        height: height,
        child: LoadingView(height: height, child: null),
      );
    }

    final int maxRow = 2; // 每页多少行
    final int maxColumn = 5; // 每行多少列
    final int limit = maxRow * maxColumn;
    final int maxPage = (_entrieList.length / limit).ceil(); // 总页数

    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      height: height,
      child: Swiper(
        outer: false,
        itemBuilder: (BuildContext context, int index) {
          int start = index * limit;
          int end = start + limit;
          List<EntrieModel> list = _entrieList.sublist(start, end);
          return _entrieItemViews(list, maxColumn);
        },
        pagination: SwiperPagination(
          margin: EdgeInsets.all(1),
          builder: RectSwiperPaginationBuilder(
              size: Size(18, 7),
              activeSize: Size(18, 7),
              color: Colors.black26,
              activeColor: Colors.blue),
        ),
        itemCount: maxPage,
      ),
    );
  }

  // 生成中心数据
  Widget _entrieItemViews(List<EntrieModel> list, int maxColumn) {
    final double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> wrapList = list.map((EntrieModel model) {
      return SizedBox(
        width: screenWidth / maxColumn,
        child: _entrieItem(model, screenWidth * 0.12, screenWidth * 0.12),
      );
    }).toList();

    return Wrap(
      runSpacing: 6.0,
      children: wrapList,
    );
  }

  // 获取单个 中心数据
  Widget _entrieItem(EntrieModel model, double width, double height) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: new Image.network(
              model.imageHash,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: new EdgeInsets.only(top: 6.0),
            child: new Text(model.name),
          )
        ],
      ),
    );
  }

  // 让 TabBarView 和 PageView 的页面切换时存活
  @override
  bool get wantKeepAlive => true;
}
