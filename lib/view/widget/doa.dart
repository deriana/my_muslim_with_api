import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muslim_app_hideri/main.dart';
import 'package:muslim_app_hideri/model/doa_model.dart';

class DoaListWidget extends StatelessWidget {
  final List<DoaModel> doaList;

  const DoaListWidget({
    super.key,
    required this.doaList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: doaList.length,
          itemBuilder: (context, index) {
            final doa = doaList[index];
            int doaIndex = index + 1;
            return GestureDetector(
              onTap: () {
                _showDoaDetailDialog(context, doa);
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
                        '$doaIndex',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        doa.doa,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const Gap(10),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
              const Gap(16), // Jarak antar item
        ),
      ],
    );
  }

  void _showDoaDetailDialog(BuildContext context, DoaModel doa) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      doa.doa,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Gap(16),
                  const Text(
                    'Ayat:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MainApp.primaryColor,
                    ),
                  ),
                  Text(
                    doa.ayat,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Gap(16),
                  const Text(
                    'Latin:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MainApp.primaryColor,
                    ),
                  ),
                  Text(
                    doa.latin,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Gap(16),
                  const Text(
                    'Artinya:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MainApp.primaryColor,
                    ),
                  ),
                  Text(
                    doa.artinya,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MainApp.primaryColor,
                    ),
                  ),
                  Gap(24),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Tutup', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
