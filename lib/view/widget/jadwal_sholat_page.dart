import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/main.dart';
import 'package:muslim_app_hideri/model/jadwal_sholat_model.dart';

class PrayerCardGrid extends StatelessWidget {
  final JadwalSholat jadwalSholat;

  const PrayerCardGrid({super.key, required this.jadwalSholat});

  @override
  Widget build(BuildContext context) {
    final jadwal = jadwalSholat.data.jadwal;

    final List<Map<String, String>> prayerTimes = [
      {
        'name': 'Imsak',
        'time': jadwal.imsak,
        'icon': 'access_alarm',
        'color': 'white',
      },
      {
        'name': 'Subuh',
        'time': jadwal.subuh,
        'icon': 'nightlight_round',
        'color': 'white',
      },
      {
        'name': 'Dzuhur',
        'time': jadwal.dzuhur,
        'icon': 'sunny',
        'color': 'white',
      },
      {
        'name': 'Ashar',
        'time': jadwal.ashar,
        'icon': 'wb_sunny',
        'color': 'white',
      },
      {
        'name': 'Maghrib',
        'time': jadwal.maghrib,
        'icon': 'sunny_snowing',
        'color': 'white',
      },
      {
        'name': 'Isya',
        'time': jadwal.isya,
        'icon': 'nights_stay',
        'color': 'white',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: prayerTimes.length,
      itemBuilder: (context, index) {
        final prayer = prayerTimes[index];
        final color = getColorFromString(prayer['color']!);

        return Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prayer['name']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    prayer['time']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    getIconFromString(prayer['icon']!),
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color getColorFromString(String colorString) {
    switch (colorString) {
      case 'white':
        return MainApp.primaryColor;
      default:
        return Colors.grey;
    }
  }

  IconData getIconFromString(String iconString) {
    switch (iconString) {
      case 'access_alarm':
        return Icons.access_alarm;
      case 'nightlight_round':
        return Icons.nightlight_round;
      case 'sunny':
        return Icons.sunny;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'sunny_snowing':
        return Icons.sunny_snowing;
      case 'nights_stay':
        return Icons.nights_stay;
      default:
        return Icons.access_alarm;
    }
  }
}
