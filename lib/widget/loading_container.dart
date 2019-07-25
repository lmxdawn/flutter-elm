import 'package:flutter/material.dart';

// 页面加载进度条
class LoadingContainer extends StatelessWidget {
  final Widget child; // 子组件
  final bool isLoading; // 是否显示loading
  final bool cover; // 是放在 child 之上

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.cover = false,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading ? child : _loadingView
        : Stack(
            children: <Widget>[
              child,
              isLoading ? _loadingView : null,
            ],
          );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
