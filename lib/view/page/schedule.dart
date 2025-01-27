import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_app_hideri/model/jadwal_sholat_model.dart';
import 'package:muslim_app_hideri/service/api.dart';
import 'package:muslim_app_hideri/view/widget/calender.dart';
import 'package:muslim_app_hideri/view/widget/fasting_widget.dart';
import 'package:muslim_app_hideri/view/widget/navbar.dart';
import 'package:muslim_app_hideri/view/widget/schedule_item.dart';

class SchedulePage extends StatefulWidget {
  final int lokasi;

  const SchedulePage({
    super.key,
    required this.lokasi,
  });

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late DateTime _selectedDay;
  bool isFastingChecked = false;

  late Future<JadwalSholat> jadwalSholat;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    jadwalSholat = fetchJadwalSholat(
      widget.lokasi,
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );
  }

  void _updateJadwalSholat(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
      // Memanggil ulang jadwal sholat berdasarkan selectedDay
      jadwalSholat = fetchJadwalSholat(
        widget.lokasi,
        _selectedDay.year,
        _selectedDay.month,
        _selectedDay.day,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 246, 242),
      body: FutureBuilder<JadwalSholat>(
        future: jadwalSholat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final jadwalSholat = snapshot.data!;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDay = DateTime.now();
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 81, 152, 140),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: CalendarWidget(
                      selectedDay: _selectedDay,
                      onDaySelected: (selectedDay) {
                        _updateJadwalSholat(
                            selectedDay); 
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FastingWidget(
                              onChanged: (bool isChecked) {
                                setState(() {
                                  isFastingChecked =
                                      isChecked; // Update fasting checkbox state
                                });
                              },
                            ),
                            Gap(10),
                            Text("Schedule",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Gap(20),
                            ScheduleItemWidget(
                              jadwalSholat: jadwalSholat,
                              isFastingChecked:
                                  isFastingChecked, // Pass fasting status
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("Tidak ada data jadwal sholat"));
          }
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 2,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/library');
              break;
            case 2:
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
