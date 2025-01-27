import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const MyBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0), 
        topRight: Radius.circular(30.0),
      ), // Border radius pada bagian atas (di sudut kiri dan kanan)
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Kiblat',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xFF00b3b8), // Warna ikon yang dipilih
        unselectedItemColor: Colors.grey, // Warna ikon yang tidak dipilih
        onTap: onItemTapped, // Fungsi untuk mengganti halaman
      ),
    );
  }
}
