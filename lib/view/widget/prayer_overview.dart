import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class PrayerOverview extends StatelessWidget {
  const PrayerOverview({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tanggal Gregorian sekarang
    DateTime now = DateTime.now();

    // Mengkonversi tanggal Gregorian ke Hijriah
    HijriCalendar hijriDate = HijriCalendar.fromDate(now);

    // Menyusun format tanggal Gregorian dan Hijriah
    String gregorianDate = '${now.day} ${_getMonthName(now.month)} ${now.year}';
    String hijriDateFormatted = '${hijriDate.hDay} ${_getHijriMonthName(hijriDate.hMonth)} ${hijriDate.hYear} H';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gregorianDate,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          hijriDateFormatted,
          style: const TextStyle(
            fontSize: 15.0,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  // Mendapatkan nama bulan Gregorian
  String _getMonthName(int month) {
    List<String> months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }

  // Mendapatkan nama bulan Hijriah
  String _getHijriMonthName(int month) {
    List<String> hijriMonths = [
      'Muharram', 'Safar', 'Rabiul Awal', 'Rabiul Akhir', 'Jumadil Awal', 'Jumadil Akhir',
      'Rajab', 'Sya’ban', 'Ramadhan', 'Syawal', 'Dzulqa’dah', 'Dzulhijjah'
    ];
    return hijriMonths[month - 1];
  }
}
