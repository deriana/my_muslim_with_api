import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/model/doa_model.dart';
import 'package:muslim_app_hideri/service/api.dart';

void main() {
  runApp(MaterialApp(
    home: DoaListScreen(),
  ));
}

class DoaListScreen extends StatefulWidget {
  @override
  _DoaListScreenState createState() => _DoaListScreenState();
}

class _DoaListScreenState extends State<DoaListScreen> {
  late Future<List<DoaModel>> futureDoa;

  @override
  void initState() {
    super.initState();
    futureDoa = fetchDoa(); // Inisialisasi fetchDoa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Doa'),
      ),
      body: FutureBuilder<List<DoaModel>>(
        future: fetchDoa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada doa yang ditemukan.'));
          } else {
            List<DoaModel> doaList = snapshot.data!;

            return ListView.builder(
              itemCount: doaList.length,
              itemBuilder: (context, index) {
                DoaModel doa = doaList[index];
                return ListTile(
                  title: Text(doa.doa),
                  subtitle: Text('Ayat: ${doa.ayat}'),
                  trailing: Icon(Icons.book),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(doa.doa),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ayat: ${doa.ayat}'),
                              SizedBox(height: 10),
                              Text('Latin: ${doa.latin}'),
                              SizedBox(height: 10),
                              Text('Artinya: ${doa.artinya}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Tutup'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
