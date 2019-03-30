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
          'https://cdn.theatlantic.com/assets/media/img/mt/2019/03/RTR483UO/lead_720_405.jpg?mod=1553029196',
      title: 'How Thailand Became the World’s Last Military Dictatorship',
      content:
          "If military dictatorship is defined in the strictest sense as the rule of a junta or military officer who comes to power through a coup and then doesn’t hold elections to offer a veneer of legitimacy, then Thailand is the world’s last military dictatorship. \nIt seems difficult to believe that such a peaceful, thriving country that welcomes millions of tourists each year is in fact a military dictatorship, let alone the last one. Yet Thailand has been through so many military coups that they almost have a business-as-usual feel to them. The reality of army rule in the country is that it is, in a political sense, thoroughly unremarkable, reliant on a familiar mix of repression and political control, with one key difference: It has the blessings of a powerful protector.",
      createAt: DateTime.now(),
    ));
    news.add(News(
      cover:
          'https://static01.nyt.com/images/2019/03/29/us/politics/29dc-TRUMP-01/merlin_152739000_7365789a-a69f-4a0d-a4a2-0ecba5372db6-superJumbo.jpg?quality=90&auto=webp',
      title:
          'Trump Threatens to Close Mexican Border Next Week Over Immigration',
      content:
          'Lake Okeechobee, Fla. — President Trump on Friday called on Mexico to stop all illegal immigration, escalating a repeated threat by adding a timeline: Mr. Trump said he would close large swaths or all of the southern border as early as “next week” if the Mexican government did not "immediately” stop all undocumented migrants.',
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
