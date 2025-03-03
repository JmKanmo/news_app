import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/**
 * 뉴스 헤더 위젯
 *
 * [달력 | 즐겨찾기 | 공지사항 ...]
 */
class NewsHeaderWidget extends StatefulWidget {
  final String locale; // 🔹 생성자로 받을 변수 추가

  // 🔹 생성자에서 `_locale` 값을 받도록 수정
  NewsHeaderWidget({required this.locale});

  @override
  State<StatefulWidget> createState() {
    return NewsHeaderWidgetState(locale: locale);
  }
}

class NewsHeaderWidgetState extends State<NewsHeaderWidget> {
  final String locale; // 🔹 생성자로 받을 변수 추가

  // 🔹 생성자에서 `_locale` 값을 받도록 수정
  NewsHeaderWidgetState({required this.locale});

  DateTime _selectedDate = DateTime.now(); // 🏆 앱 실행 시 기본값 = 오늘 날짜

  // 📅 날짜 선택 팝업 (OK/CANCEL 없이 즉시 반영, 화면 중앙에 표시)
  void _selectDate(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("날짜 선택"),
          content: Container(
            height: 350, // 팝업 크기 설정
            width: 300,
            child: CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onDateChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate; // ✅ 날짜 선택 즉시 반영
                });
                Navigator.pop(context); // ✅ 날짜 선택 후 팝업 자동 닫힘
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.calendar_today, color: Colors.blue, size: 30),
          onPressed: () => _selectDate(context),
        ),
        SizedBox(width: 10),
        Text(
          DateFormat.yMMMMd(locale).format(_selectedDate),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
