import 'package:flutter/material.dart';
import 'package:flutter_elm/utils/dio_util.dart';
import 'package:dio/dio.dart';

class SecondPage extends StatelessWidget {
  final String title;

  SecondPage({Key key, this.title = "嘿嘿"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getAll().then((data) {
      print('Http response: ${data[0]['d'][0]['content']}');
    }).catchError((onError) {
      print("出现错误！！！");
      print(onError);
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

  Future _getHttp() async {
    var dio = DioUtil.http();

    Response<Map<String, dynamic>> response =
        await dio.get("/activity_link.json");

    return response.data;
  }

  Future _getHttp1() async {
    var dio = DioUtil.http();

    Response<Map<String, dynamic>> response =
        await dio.get("/activity_link.json");

    return response.data;
  }

  Future _getAll() async {
  
    List<dynamic> responses = await Future.wait([_getHttp(), _getHttp1()]);

    return responses;
  }

}
