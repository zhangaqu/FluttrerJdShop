import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config.dart';
import 'package:flutter_app/model/CateModel.dart';
import 'package:flutter_app/services/ScreenAdaper.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  Widget _leftCateWidget(leftWidth) {
    if (_leftCateList.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemCount: _leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      this._selectIndex = index;
                      _getRightCateData(_leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(84),
                    child: Padding(
                        child: Text(
                          "${_leftCateList[index].title}",
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.only(top: ScreenAdapter.height(24))),
                    color: _selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
//                  Divider()
              ],
            );
          },
        ),
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(5),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth / rightItemHeight,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: _rightCateList.length,
              itemBuilder: (context, index) {
                //处理图片
                String pic = this._rightCateList[index].pic;
                pic = Config.domain + pic.replaceAll('\\', '/');

                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/productList',arguments: {
                      "cid":this._rightCateList[index].sId
                    });
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network("${pic}", fit: BoxFit.cover),
                        ),
                        Container(
                          height: ScreenAdapter.height(28),
                          child: Text(
                            "${this._rightCateList[index].title}",
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  )
                );
              }),
        ),
      );
    } else {
      return Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
          ));
    }
  }

  _getLeftCateData() async {
    var api = "${Config.domain}api/pcate";
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    setState(() {
      this._leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[0].sId);
  }

  //右侧分类
  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=${pid}';
    var result = await Dio().get(api);
    var rightCateList = new CateModel.fromJson(result.data);

    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    //计算右侧GridView宽高比

    //左侧宽度

    var leftWidth = ScreenAdapter.getScreenWidth() / 4;

    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3

    var rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 20 - 20) / 3;

    //获取计算后的宽度
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    //获取计算后的高度
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);
    return Row(
      children: <Widget>[
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }
}
