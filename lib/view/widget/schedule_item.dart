import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/model/jadwal_sholat_model.dart';

class ScheduleItemWidget extends StatelessWidget {
  final JadwalSholat jadwalSholat;

  const ScheduleItemWidget({
    super.key,
    required this.jadwalSholat,
  });

  @override
  Widget build(BuildContext context) {
    final jadwal = jadwalSholat.data.jadwal;

    // Map your data here
    final List<Map<String, String>> prayerTimes = [
      {
        'name': 'Imsak',
        'time': jadwal.imsak,
        'icon': 'access_alarm',
        'color': 'purple',
      },
      {
        'name': 'Subuh',
        'time': jadwal.subuh,
        'icon': 'nightlight_round',
        'color': 'purple',
      },
      {
        'name': 'Dzuhur',
        'time': jadwal.dzuhur,
        'icon': 'sunny',
        'color': 'blue',
      },
      {
        'name': 'Ashar',
        'time': jadwal.ashar,
        'icon': 'wb_sunny',
        'color': 'orange',
      },
      {
        'name': 'Maghrib',
        'time': jadwal.maghrib,
        'icon': 'sunny_snowing',
        'color': 'orange',
      },
      {
        'name': 'Isya',
        'time': jadwal.isya,
        'icon': 'nights_stay',
        'color': 'purple',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: prayerTimes.length,
      itemBuilder: (context, index) {
        final prayer = prayerTimes[index];
        final color = getColorFromString(prayer['color']!);

        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomPaint(
                    size: Size(2, 70),
                    painter: LinePainter(),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        getIconFromString(prayer['icon']!),
                        color: color,
                        size: 24,
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prayer['name']!,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            prayer['time']!,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color getColorFromString(String colorString) {
    switch (colorString) {
      case 'blueGrey':
        return Colors.blueGrey;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'purple':
        return Colors.purple;
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

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 81, 152, 140) // Color of the line
      ..strokeWidth = 2; // Stroke width for the line

    // Drawing the vertical line at the center of the widget
    double centerX = size.width / 2;
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
