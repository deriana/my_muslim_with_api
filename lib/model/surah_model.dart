class SurahModel {
  final int code;
  final String message;
  final List<Surah> data;

  SurahModel({required this.code, required this.message, required this.data});

  // Fungsi untuk membuat objek SurahModel dari JSON
  factory SurahModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Surah> surahList = list.map((i) => Surah.fromJson(i)).toList();

    return SurahModel(
      code: json['code'],
      message: json['message'],
      data: surahList,
    );
  }

  // Fungsi untuk mengubah objek SurahModel menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((surah) => surah.toJson()).toList(),
    };
  }
}

// Model untuk setiap Surah dalam data
class Surah {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;

  Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
  });

  // Fungsi untuk membuat objek Surah dari JSON
  factory Surah.fromJson(Map<String, dynamic> json) {
    var audioMap = json['audioFull'] != null
        ? Map<String, String>.from(json['audioFull'])
        : <String, String>{};

    return Surah(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
      tempatTurun: json['tempatTurun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      audioFull: audioMap,
    );
  }

  // Fungsi untuk mengubah objek Surah menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'nomor': nomor,
      'nama': nama,
      'namaLatin': namaLatin,
      'jumlahAyat': jumlahAyat,
      'tempatTurun': tempatTurun,
      'arti': arti,
      'deskripsi': deskripsi,
      'audioFull': audioFull,
    };
  }
}
