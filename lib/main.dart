import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/view/page/compass.dart';
import 'package:muslim_app_hideri/view/page/home_page.dart';
import 'package:muslim_app_hideri/view/page/library.dart';
import 'package:muslim_app_hideri/view/page/schedule.dart';
import 'package:muslim_app_hideri/view/page/splashscreen.dart';
import 'package:muslim_app_hideri/view/widget/surah_detail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const Color secondaryColor = Color(0xFF007f8e);
  static const Color primaryColor = Color(0xFF00b3b8);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // route awal splash screen
      routes: {
        '/splash': (context) => SplashScreen(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
        '/': (context) => HomePage(
              lokasi: 1206,
              tahun: now.year,
              bulan: now.month,
              hari: now.day,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
        '/schedule': (context) => SchedulePage(
              lokasi: 1206,
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
        '/library': (context) => LibraryPage(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
        '/surah': (context) => SurahDetailPage(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
        '/kiblat': (context) => CompassPage(
              primaryColor: primaryColor,
              secondaryColor: secondaryColor,
            ),
      },
    );
  }
}
