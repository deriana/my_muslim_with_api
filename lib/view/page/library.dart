import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_app_hideri/main.dart';
import 'package:muslim_app_hideri/model/doa_model.dart';
import 'package:muslim_app_hideri/service/api.dart';
import 'package:muslim_app_hideri/view/widget/doa.dart';
import 'package:muslim_app_hideri/view/widget/navbar.dart';
import 'package:muslim_app_hideri/view/widget/surah.dart';
import 'package:muslim_app_hideri/model/surah_model.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key, required Color primaryColor, required Color secondaryColor});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool isSurahSelected = true;
  List<Surah> filteredSurahList = [];
  List<Surah> allSurahList = [];
  List<DoaModel> filteredDoaList = [];
  List<DoaModel> allDoaList = [];
  final TextEditingController _searchController = TextEditingController(); // Controller untuk pencarian

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
    // Memanggil API untuk mendapatkan data doa
    fetchDoa().then((doaModelList) {
      setState(() {
        allDoaList = doaModelList; // Semua data doa tanpa filter
        filteredDoaList = allDoaList; // Menampilkan data doa pada awalnya
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
            .where((surah) => surah.nama.toLowerCase().contains(query.toLowerCase())) // Filter berdasarkan nama surah
            .toList();
      });
    }
  }

  // Fungsi untuk memfilter doa berdasarkan nama doa
  void filterDoaList(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredDoaList = allDoaList; // Jika pencarian kosong, tampilkan semua doa
      });
    } else {
      setState(() {
        filteredDoaList = allDoaList
            .where((doa) => doa.doa.toLowerCase().contains(query.toLowerCase())) // Filter berdasarkan nama doa
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
              "../../assets/bg-blue.jpg", // Pastikan path gambar benar
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
                  flex: 3, // Lebih besar untuk gambar (proporsi 7 bagian)
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3, // Lebih kecil untuk konten utama (proporsi 3 bagian)
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
                          // Search Bar untuk pencarian surah dan doa
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (query) {
                                if (isSurahSelected) {
                                  filterSurahList(query); // Memanggil filter surah
                                } else {
                                  filterDoaList(query); // Memanggil filter doa
                                }
                              }, // Memanggil filter setiap kali teks diubah
                              decoration: const InputDecoration(
                                labelText: 'Search Surah or Doa',
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
                              color: MainApp.primaryColor,
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
                                      color: isSurahSelected ? MainApp.secondaryColor : Colors.white,
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
                                      color: !isSurahSelected ? MainApp.secondaryColor : Colors.white,
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
                                  : Center(child: CircularProgressIndicator()) // Tampil jika tidak ada hasil
                              : filteredDoaList.isNotEmpty
                                  ? DoaListWidget(doaList: filteredDoaList) // Menampilkan Doa yang difilter
                                  : Center(child: CircularProgressIndicator()) // Tampil jika tidak ada hasil
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
