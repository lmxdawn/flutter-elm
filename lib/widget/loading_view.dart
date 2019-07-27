import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {

  final double height;
  final double width;

  final String text;

  const LoadingView({Key key, this.text = "", this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: Color(0xFFf5f7fa)),
      child: Center(
        child: text.length > 0
            ? Text(
                text,
                style: TextStyle(color: Color(0xFFc0c4cc), fontSize: 16),
              )
            : null,
      ),
    );
  }
}
