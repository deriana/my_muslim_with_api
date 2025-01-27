import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/model/surah_model.dart'; 

class SurahListWidget extends StatelessWidget {
  final List<Surah> surahList; 

  const SurahListWidget({
    super.key,
    required this.surahList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true, 
          physics: NeverScrollableScrollPhysics(), 
          itemCount: surahList.length, 
          itemBuilder: (context, index) {
            final surah = surahList[index]; 
            int surahIndex = index + 1;
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/surah',
                  arguments: surah.nomor, 
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$surahIndex',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.nama,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        surah.namaLatin,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
