import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart'; // Import package intl untuk format waktu

class HighlightCard extends StatelessWidget {
  const HighlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil waktu saat ini
    final now = DateTime.now();
    
    // Memformat tanggal dalam format "Hari, Tanggal"
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(now);

    // Memformat waktu dalam format "Jam:Menit"
    final formattedTime = DateFormat('HH:mm').format(now);

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('../../assets/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formattedDate, // Tanggal saat ini
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Gap(10),
            Text(
              formattedTime, // Waktu saat ini
              style: const TextStyle(
                color: Colors.white,
                fontSize: 29,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(width: 10),
                Text(
                  'Cianjur, Jawa Barat, Indonesia', // Lokasi tetap
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
