import 'package:flutter/material.dart';
import 'package:news_reader/data/news.dart';
import 'package:news_reader/models/headline_model.dart';
import 'package:news_reader/screens/feed/news_card.dart';
import 'package:news_reader/screens/news_detail/news_detail_page.dart';
import 'package:scoped_model/scoped_model.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    HeadlineModel headlineModel = ScopedModel.of<HeadlineModel>(context);
    headlineModel.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HeadlineModel>(
        builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
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
      );
    });
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
