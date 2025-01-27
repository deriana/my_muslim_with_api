import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muslim_app_hideri/model/doa_model.dart';
import 'package:muslim_app_hideri/model/jadwal_sholat_model.dart';
import 'package:muslim_app_hideri/model/surah_model.dart';
import 'package:muslim_app_hideri/model/surah_model_id.dart';

Future<JadwalSholat> fetchJadwalSholat(
    int lokasi, int tahun, int bulan, int hari) async {
  final url =
      'https://api.myquran.com/v2/sholat/jadwal/$lokasi/$tahun/$bulan/$hari';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return JadwalSholat.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<SurahModel> fetchSurat() async {
  final url = 'https://equran.id/api/v2/surat';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return SurahModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<SurahModelById> fetchSuratById(int surahId) async {
  final url = 'https://equran.id/api/v2/surat/$surahId';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return SurahModelById.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<DoaModel>> fetchDoa() async {
  final url =
      'https://api.allorigins.win/raw?url=https://doa-doa-api-ahmadramadhan.fly.dev/api';
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
  }).timeout(Duration(seconds: 10));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    return data.map((item) => DoaModel.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load doa');
  }
}
