import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/main.dart';
import 'package:muslim_app_hideri/model/surah_model_id.dart';
import 'package:muslim_app_hideri/service/api.dart'; // Menyesuaikan dengan API service kamu
import 'package:gap/gap.dart';

class SurahDetailPage extends StatefulWidget {
  const SurahDetailPage(
      {super.key, required Color primaryColor, required Color secondaryColor});

  @override
  _SurahDetailPageState createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  late int surahId;
  late Future<SurahModelById> surahDetail;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as int;
    surahId = args;
    surahDetail = fetchSuratById(surahId); // Mengambil data surat sesuai ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainApp.primaryColor,
      appBar: AppBar(
        title: Text('Detail Surat', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<SurahModelById>(
        future: surahDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No data available.'));
          }

          var data = snapshot.data!.data;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data.namaLatin,
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Gap(10),
                  Text(
                    data.nama,
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Gap(10),
                  Text(
                    "Arti: ${data.arti}",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  Gap(20),
                  Text(
                    "Deskripsi: ${data.deskripsi}",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  Gap(20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.ayat.length,
                    itemBuilder: (context, index) {
                      var ayat = data.ayat[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Ayat ${ayat.nomorAyat}",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              ayat.teksArab,
                              style: TextStyle(
                                  fontSize: 22.0, color: Colors.white),
                            ),
                            Text(
                              ayat.teksIndonesia,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              textAlign: TextAlign.end,
                            ),
                            Gap(10),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.play_arrow, color: Colors.white),
                                  onPressed: () {
                                    // Log saat audio diklik
                                    // Putar audio saat ditekan (implementasi lebih lanjut)
                                  },
                                ),
                                Text("Audio Ayat ${ayat.nomorAyat}", style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            Gap(20),
                          ],
                        ),
                      );
                    },
                  ),
                  Gap(20),
                  // Tombol Next/Previous
                  // Menghitung jika `suratSelanjutnya` bukan null atau false
                  if (data.suratSelanjutnya != null)
                    ElevatedButton(
                      onPressed: () {
                        // Log saat tombol diklik untuk Surat Selanjutnya
                        Navigator.pushNamed(
                          context,
                          '/surah',
                          arguments: data.nomor + 1,
                        );
                      },
                      child: Text(
                        "Surat Selanjutnya",
                        style: TextStyle(color: MainApp.primaryColor),
                      ),
                    ),
                  // Menangani `suratSebelumnya`, perlu periksa jika bukan false atau null
                  if (data.suratSebelumnya != false)
                    ElevatedButton(
                      onPressed: () {
                        // Log saat tombol diklik untuk Surat Sebelumnya
                        Navigator.pushNamed(
                          context,
                          '/surah',
                          arguments: data.suratSebelumnya.nomor,
                        );
                      },
                      child: Text("Surat Sebelumnya", style: TextStyle(color: MainApp.primaryColor)),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
