import 'package:flutter/material.dart';
import 'package:flutter_elm/utils/dio_util.dart';
import 'package:dio/dio.dart';

class SecondPage extends StatelessWidget {

  final String title;

  SecondPage({Key key, this.title = "嘿嘿"}): super(key: key);

  @override
  Widget build(BuildContext context) {
    _getHttp().then((data) {
    print('Http response: $data');
  });
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: 36.0),
        ),
        backgroundColor: Colors.pinkAccent,
        leading: Container(),
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
            child: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 64.0,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
    );
  }

  _getHttp() async {
    
    var dio = DioUtil.http();
    Response response = await dio.get("/activity_link.json");
    // print(response.data);
    
  }

}
