import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_reader/data/news.dart';
import 'package:news_reader/screens/feed/news_card.dart';
import 'package:news_reader/screens/news_detail/news_detail_page.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<News> news = List<News>();
  bool isLoading = false;

  _fetchNews() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get('https://newsapi.org/v2/top-headlines'
        '?sources=techcrunch&apiKey=6316e304547d4808b3a632a04c45ad89');
    var responseJson = json.decode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(responseJson);
    setState(() {
      news = newsResponse.articles;
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
