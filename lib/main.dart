import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/view/page/home_page.dart';
import 'package:muslim_app_hideri/view/page/schedule.dart';

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
        // '/library': (context) => LibraryPage(),
        // '/kiblat': (context) => CompassPage(),
        // '/surah': (context) => SurahDetailPage(),
        // '/doa': (context) => DoaDetailPage(),
      },
    );
  }
}
