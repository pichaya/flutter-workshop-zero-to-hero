import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/configs/config.dart';
import 'package:news_reader/screens/home/home_page.dart';

class NewsReaderApp extends StatelessWidget {
  NewsReaderApp(this._config);

  final Config _config;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            title: _config.appName,
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          )
        : MaterialApp(
            title: _config.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage(),
          );
  }
}
