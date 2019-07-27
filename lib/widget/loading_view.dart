import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {

  final double height;
  final double width;
  final Widget child;

  const LoadingView({Key key, this.child, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Color(0xFFf5f7fa)),
      child: child,
    );
  }
}
