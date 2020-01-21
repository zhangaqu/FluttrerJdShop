import 'package:flutter/material.dart';

import 'CategoryPage.dart';
import 'HomePage.dart';
import 'ShopCarPage.dart';
import 'UserPage.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  PageController _pageController;

  List<Widget> _currentPageList = [
    HomePage(),
    CategoryPage(),
    ShopCarPage(),
    UserPage(),
  ];

  @override
  void initState() {
    super.initState();
    this._pageController=new PageController(initialPage:this._currentIndex );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text('jdshop'),
//        ),
        body: PageView(
          controller: this._pageController,
          children: this._currentPageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: this._currentIndex,
            onTap: (index) {
              setState(() {
                this._currentIndex = index;
                this._pageController.jumpToPage(index);
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('首页'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), title: Text('分类')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), title: Text('购物车')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), title: Text('我的')),
            ]));
  }
}
