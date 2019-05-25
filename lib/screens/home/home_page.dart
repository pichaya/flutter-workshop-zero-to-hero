import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/data/news.dart';
import 'package:news_reader/screens/home/widgets/news_card.dart';
import 'package:news_reader/screens/news_detail/news_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  List<News> news = List<News>();

  @override
  void initState() {
    news.add(News(
      cover:
          'https://cdn.mos.cms.futurecdn.net/vHdvWTgFUsVq7r73rVPPh6-970-80.jpg',
      title: 'Huawei ban: the global fallout explained [Updated]',
      content:
          "Huawei has found itself at the center of a global tussle between the US and China after Trump administration placed the Chinese brand on the ‘entity list’, limiting the business US companies could do with it.",
      createAt: DateTime.now(),
    ));
    news.add(News(
      cover:
          'https://cdn.mos.cms.futurecdn.net/LzBAUxudHEegMhNd9ynPbV-970-80.jpg',
      title:
          'Apple improved the 2019 MacBook Pro keyboards after all, iFixit uncovers',
      content:
          'Apple didn’t just improve the processors within its existing MacBook Pro models, but apparently the company has also improved the keyboards that these refreshed laptops offer, teardown site iFixit has learned.',
      createAt: DateTime.now(),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.assistant),
        title: Text('My Feed'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.work),
        title: Text('Headline'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star_border),
        title: Text('Favorites'),
      ),
    ];
    Widget child = Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: news.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  openDetailPage(news[index]);
                },
                child: NewsCard(news[index]),
              ),
            );
          }),
    );
    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(items: navItems),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text(
                    'Headlines',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                child: child,
              );
            },
          )
        : Scaffold(
            appBar: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              title: Text(
                'Headlines',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              actions: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://png.pngtree.com/element_origin_min_pic/16/11/15/89a1f35d71139a37bb3fe572a954f2f8.jpg'),
                    ),
                  ),
                )
              ],
            ),
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: navItems,
              onTap: (int index) {
                setState(() {
                  pageIndex = index;
                });
              },
              currentIndex: pageIndex,
            ),
          );
  }

  void openDetailPage(News news) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return NewsDetailPage(news: news);
      }),
    );
  }
}
