import 'package:flutter/material.dart';
import 'package:news_reader/configs/config.dart';
import 'package:news_reader/models/headline_model.dart';
import 'package:news_reader/screens/home/home_page.dart';
import 'package:provider/provider.dart';

class NewsReaderApp extends StatelessWidget {
  NewsReaderApp(this._config);

  final Config _config;

  @override
  Widget build(BuildContext context) {
    return Provider<HeadlineModel>(
      builder: (_) => HeadlineModel(),
      child: MaterialApp(
        title: _config.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
