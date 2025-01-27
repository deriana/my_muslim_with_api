import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muslim_app_hideri/model/jadwal_sholat_model.dart';

Future<JadwalSholat> fetchJadwalSholat(int lokasi, int tahun, int bulan, int hari) async {
  final url = 'https://api.myquran.com/v2/sholat/jadwal/$lokasi/$tahun/$bulan/$hari';
  
  final response = await http.get(Uri.parse(url));
  
  if (response.statusCode == 200) {
    return JadwalSholat.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
