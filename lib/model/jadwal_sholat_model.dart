class JadwalSholat {
  final bool status;
  final Request request;
  final Data data;

  JadwalSholat({required this.status, required this.request, required this.data});

  factory JadwalSholat.fromJson(Map<String, dynamic> json) {
    return JadwalSholat(
      status: json['status'],
      request: Request.fromJson(json['request']),
      data: Data.fromJson(json['data']),
    );
  }
}

class Request {
  final String path;

  Request({required this.path});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(path: json['path']);
  }
}

class Data {
  final int id;
  final String lokasi;
  final String daerah;
  final Jadwal jadwal;

  Data({required this.id, required this.lokasi, required this.daerah, required this.jadwal});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      lokasi: json['lokasi'],
      daerah: json['daerah'],
      jadwal: Jadwal.fromJson(json['jadwal']),
    );
  }
}

class Jadwal {
  final String tanggal;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;
  final String date;

  Jadwal({
    required this.tanggal,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
    required this.date,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      tanggal: json['tanggal'],
      imsak: json['imsak'],
      subuh: json['subuh'],
      terbit: json['terbit'],
      dhuha: json['dhuha'],
      dzuhur: json['dzuhur'],
      ashar: json['ashar'],
      maghrib: json['maghrib'],
      isya: json['isya'],
      date: json['date'],
    );
  }

  toJson() {}
}
