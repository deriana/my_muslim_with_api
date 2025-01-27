import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_app_hideri/service/api.dart';
import 'package:muslim_app_hideri/view/widget/doa.dart';
import 'package:muslim_app_hideri/view/widget/navbar.dart';
import 'package:muslim_app_hideri/view/widget/surah.dart';
import 'package:muslim_app_hideri/model/surah_model.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool isSurahSelected = true;
  List<Surah> filteredSurahList = [];
  List<Surah> allSurahList = [];
  final TextEditingController _searchController = TextEditingController(); // Kontroler pencarian

  @override
  void initState() {
    super.initState();
    // Memanggil API untuk mendapatkan data surah
    fetchSurat().then((surahModel) {
      setState(() {
        allSurahList = surahModel.data; // Semua data surah tanpa filter
        filteredSurahList = allSurahList; // Menampilkan data surah pada awalnya
      });
    });
  }

  // Fungsi untuk memfilter surah berdasarkan nama
  void filterSurahList(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredSurahList = allSurahList; // Jika pencarian kosong, tampilkan semua surah
      });
    } else {
      setState(() {
        filteredSurahList = allSurahList
            .where((surah) =>
                surah.namaLatin.toLowerCase().contains(query.toLowerCase())) // Filter berdasarkan nama surah
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "../../assets/kabah.jpg", // Pastikan path gambar benar
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          // Content
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 1, // Lebih besar untuk gambar (proporsi 7 bagian)
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6, // Lebih kecil untuk konten utama (proporsi 3 bagian)
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search Bar untuk pencarian surah
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              controller: _searchController,
                              onChanged: filterSurahList, // Memanggil filter setiap kali teks diubah
                              decoration: const InputDecoration(
                                labelText: 'Search Surah',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                          ),
                          const Gap(20),
                          // Bar untuk memilih Surah atau Doa
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 223, 246, 242),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSurahSelected = true; // Menampilkan Surah
                                    });
                                  },
                                  child: Text(
                                    "Surah",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isSurahSelected
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSurahSelected = false; // Menampilkan Doa
                                    });
                                  },
                                  child: Text(
                                    "Doa",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: !isSurahSelected
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(20),
                          // Menampilkan konten yang sesuai berdasarkan tab yang dipilih
                          isSurahSelected
                              ? filteredSurahList.isNotEmpty
                                  ? SurahListWidget(surahList: filteredSurahList) // Menampilkan Surah yang difilter
                                  : Center(child: CircularProgressIndicator(),) // Tampil jika tidak ada hasil
                              : FutureBuilder<SurahModel>(
                                  // Menampilkan Doa (saat tab Doa dipilih)
                                  future: fetchSurat(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(child: Text('Error: ${snapshot.error}'));
                                    } else if (snapshot.hasData) {
                                      return DoaListWidget(
                                          surahList: snapshot.data!.data); // Menampilkan Doa
                                    } else {
                                      return const Center(child: Text('No data available'));
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              break;
            case 2:
              Navigator.pushNamed(context, '/schedule');
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
