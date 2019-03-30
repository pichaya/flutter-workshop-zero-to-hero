import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_reader/data/news.dart';

class NewsDetailPage extends StatefulWidget {
  NewsDetailPage({@required this.news});
  final News news;

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  ScrollController _scrollController = ScrollController();
  double appBarExpandedHeight;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() => setState(() {}));
  }

  bool get _isExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (appBarExpandedHeight - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          brightness: Brightness.light,
          elevation: 0,
          iconTheme:
              IconThemeData(color: _isExpanded ? Colors.black : Colors.white),
          backgroundColor: Colors.white,
          expandedHeight: appBarExpandedHeight,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Image.network(
                        widget.news.cover,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Expanded(
                  child: Image.network(
                    widget.news.cover,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ]),
        )
      ],
    );
    appBarExpandedHeight = MediaQuery.of(context).size.width * (0.5);
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                widget.news.title,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
            child: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      widget.news.cover,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(widget.news.content),
                  )
                ],
              ),
            )))
        : Scaffold(
            body: child,
          );
  }
}
