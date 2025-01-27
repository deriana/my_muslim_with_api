import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_app_hideri/model/jadwal_sholat_model.dart';
import 'package:muslim_app_hideri/service/api.dart';
import 'package:muslim_app_hideri/view/widget/highlight_card.dart';
import 'package:muslim_app_hideri/view/widget/jadwal_sholat_page.dart';
import 'package:muslim_app_hideri/view/widget/navbar.dart';
import 'package:muslim_app_hideri/view/widget/prayer_overview.dart';
import 'package:muslim_app_hideri/view/widget/schedule_item.dart';

class SchedulePage extends StatelessWidget {
  final int lokasi;
  final int tahun;
  final int bulan;
  final int hari;

  SchedulePage({
    required this.lokasi,
    required this.tahun,
    required this.bulan,
    required this.hari,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FutureBuilder<JadwalSholat>(
        future: fetchJadwalSholat(lokasi, tahun, bulan, hari),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final jadwalSholat = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PrayerOverview(),
                    const Gap(10),
                    HighlightCard(),
                    const Gap(20),
                    Text(
                      "Prayer Time",
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    ScheduleItemWidget(jadwalSholat: jadwalSholat),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text("Tidak ada data jadwal sholat"));
          }
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 0,
        onItemTapped: (index) {
          // Fungsi navigasi ke halaman terkait jika perlu
          switch (index) {
            case 0:
              // Halaman Home sudah aktif
              break;
            case 1:
              Navigator.pushNamed(context, '/library');
              break;
            case 2:
              Navigator.pushNamed(context, '/schedule');
              break;
            case 3:
              Navigator.pushNamed(context, '/kiblat');
              break;
          }
        },
      ),
    );
  }
}
