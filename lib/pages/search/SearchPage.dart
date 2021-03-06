import 'package:flutter/material.dart';
import 'package:flutter_app/services/ScreenAdaper.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide:BorderSide.none,
                    borderRadius: BorderRadius.circular(30)
                )
              ),
            ),
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)
        ),
      ),
      actions: <Widget>[
        InkWell(
          child: Container(
            height: ScreenAdapter.height(68),
            width: ScreenAdapter.width(80),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[Text("搜索",textAlign: TextAlign.center,)],
            ),
          ),
          onTap: () {

          },
        )
      ],
    ),
    body: Text('text'),);
  }
}
