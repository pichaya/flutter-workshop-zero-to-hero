import 'package:flutter/material.dart';
import 'package:news_reader/data/news.dart';
import 'package:news_reader/models/headline_model.dart';
import 'package:news_reader/screens/feed/news_card.dart';
import 'package:news_reader/screens/news_detail/news_detail_page.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  HeadlineModel model;
  @override
  void didChangeDependencies() {
    model = Provider.of<HeadlineModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: model.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              child: ListView.builder(
                  itemCount: model.newsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: () {
                          openDetailPage(model.newsList[index]);
                        },
                        child: NewsCard(model.newsList[index]),
                      ),
                    );
                  }),
              onRefresh: () async {
                model.fetchNews();
              },
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
