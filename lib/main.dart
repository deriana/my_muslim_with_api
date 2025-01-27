import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/view/page/home_page.dart';
import 'package:muslim_app_hideri/view/page/library.dart';
import 'package:muslim_app_hideri/view/page/schedule.dart';
import 'package:muslim_app_hideri/view/page/test.dart';
import 'package:muslim_app_hideri/view/widget/surah_detail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(
              lokasi: 1206,
              tahun: now.year,
              bulan: now.month,
              hari: now.day,
            ),
        '/schedule': (context) => SchedulePage(
              lokasi: 1206,
            ),
        '/test': (context) => SurahListPage(),
        '/library': (context) => LibraryPage(),
        // '/kiblat': (context) => CompassPage(),
        '/surah': (context) => SurahDetailPage(),
        // '/doa': (context) => DoaDetailPage(),
      },
    );
  }
}
