class SurahModelById {
  int code;
  String message;
  Data data;

  SurahModelById({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SurahModelById.fromJson(Map<String, dynamic> json) {
    return SurahModelById(
      code: json['code'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  String arti;
  String deskripsi;
  Map<String, String> audioFull;
  List<Ayat> ayat;
  SuratSebPrev? suratSelanjutnya;  // Perubahan, sekarang menjadi SuratSebPrev
  dynamic suratSebelumnya;  // Perubahan, dapat menjadi SuratSebPrev atau false

  Data({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
    required this.suratSelanjutnya,
    required this.suratSebelumnya,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var ayatList = <Ayat>[];
    if (json['ayat'] != null) {
      json['ayat'].forEach((v) {
        ayatList.add(Ayat.fromJson(v));
      });
    }

    return Data(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
      tempatTurun: json['tempatTurun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      audioFull: Map<String, String>.from(json['audioFull']),
      ayat: ayatList,
      suratSelanjutnya: json['suratSelanjutnya'] != false
          ? SuratSebPrev.fromJson(json['suratSelanjutnya'])
          : null,  // Jika tidak `false`, baru kita convert menjadi objek SuratSebPrev
      suratSebelumnya: json['suratSebelumnya'] is bool
          ? json['suratSebelumnya']  // Jika berupa bool, simpan `false`
          : SuratSebPrev.fromJson(json['suratSebelumnya']),  // Jika bukan bool, konversi menjadi objek SuratSebPrev
    );
  }

  Map<String, dynamic> toJson() {
    var ayatList = ayat.map((v) => v.toJson()).toList();
    return {
      'nomor': nomor,
      'nama': nama,
      'namaLatin': namaLatin,
      'jumlahAyat': jumlahAyat,
      'tempatTurun': tempatTurun,
      'arti': arti,
      'deskripsi': deskripsi,
      'audioFull': audioFull,
      'ayat': ayatList,
      'suratSelanjutnya': suratSelanjutnya?.toJson(), // Jika ada suratSelanjutnya, kita convert menjadi json
      'suratSebelumnya': suratSebelumnya is bool
          ? suratSebelumnya
          : suratSebelumnya?.toJson(), // Jika suratSebelumnya berupa bool, tidak usah diproses, jika objek convert menjadi json
    };
  }
}

class Ayat {
  int nomorAyat;
  String teksArab;
  String teksLatin;
  String teksIndonesia;
  Map<String, String> audio;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      nomorAyat: json['nomorAyat'],
      teksArab: json['teksArab'],
      teksLatin: json['teksLatin'],
      teksIndonesia: json['teksIndonesia'],
      audio: Map<String, String>.from(json['audio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomorAyat': nomorAyat,
      'teksArab': teksArab,
      'teksLatin': teksLatin,
      'teksIndonesia': teksIndonesia,
      'audio': audio,
    };
  }
}

class SuratSebPrev {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;

  SuratSebPrev({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SuratSebPrev.fromJson(Map<String, dynamic> json) {
    return SuratSebPrev(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['namaLatin'],
      jumlahAyat: json['jumlahAyat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomor': nomor,
      'nama': nama,
      'namaLatin': namaLatin,
      'jumlahAyat': jumlahAyat,
    };
  }
}
