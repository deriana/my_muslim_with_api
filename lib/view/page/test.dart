import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/model/surah_model.dart'; // Import model
import 'package:muslim_app_hideri/service/api.dart';
import 'package:muslim_app_hideri/view/widget/surah.dart';


class SurahListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Surat Al-Quran'),
      ),
      body: FutureBuilder<SurahModel>(
        future: fetchSurat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var surahList = snapshot.data!.data; // Mendapatkan list surah
            return SurahListWidget(surahList: surahList); // Menggunakan widget yang sudah dibuat
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
