import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // 🌍 로케일 초기화
import 'dart:io';
import 'package:news_app/widget/NewsHeaderWidget.dart';

/**
 * 뉴스 UI 위젯
 * 각 Depth 별로 위젯 구성
 **/
class NewsWidget extends StatefulWidget {
  @override
  State<NewsWidget> createState() => _NewsWidget();
}

class _NewsWidget extends State<NewsWidget> {
  late String _locale;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeDateFormatting();
  }

  // 📌 로케일 데이터 초기화
  Future<void> _initializeDateFormatting() async {
    await initializeDateFormatting();
    setState(() {
      _locale = _getSystemLocale();
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('NewsWorld')), // (최상단 앱바)
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          children: <Widget>[
            NewsHeaderWidget(locale: _locale), // ✅ `_locale` 값 전달
          ],
        ),
      ),
    );
  }
}

// 🌍 OS 언어 감지 (intl 초기화 문제 해결)
String _getSystemLocale() {
  try {
    Intl.defaultLocale = Platform.localeName;
    return Platform.localeName.substring(0, 2);
  } catch (e) {
    debugPrint("[NewsWidget:_getSystemLocale] error: $e");
    return "en";
  }
}
