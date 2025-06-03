import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim_app_hideri/view/page/neu_circle.dart';
import 'package:muslim_app_hideri/view/widget/navbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class CompassPage extends StatefulWidget {
  const CompassPage({super.key, required Color primaryColor, required Color secondaryColor});

  @override
  _CompassPageState createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  int _selectedIndex = 3;
  bool _hasPermissions = false;
  double? _direction;      // arah kompas device
  double? _qiblaAngle;     // sudut arah Qibla
  Position? _currentPosition;

  static const double kaabaLatitude = 21.422487;
  static const double kaabaLongitude = 39.826206;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetLocation();
    FlutterCompass.events?.listen((event) {
      if (event.heading != null) {
        setState(() {
          _direction = event.heading!;
        });
      }
    });
  }

  void _checkPermissionsAndGetLocation() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      status = await Permission.locationWhenInUse.request();
    }
    if (status.isGranted) {
      setState(() {
        _hasPermissions = true;
      });
      await _getCurrentLocation();
    } else {
      setState(() {
        _hasPermissions = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _qiblaAngle = _calculateQiblaAngle(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  double _calculateQiblaAngle(double lat, double lon) {
    final kaabaLat = kaabaLatitude * (math.pi / 180);
    final kaabaLon = kaabaLongitude * (math.pi / 180);
    final userLat = lat * (math.pi / 180);
    final userLon = lon * (math.pi / 180);

    final deltaLon = kaabaLon - userLon;
    final x = math.sin(deltaLon);
    final y = math.cos(userLat) * math.tan(kaabaLat) - math.sin(userLat) * math.cos(deltaLon);

    double angle = math.atan2(x, y);
    angle = angle * (180 / math.pi);
    if (angle < 0) angle += 360;
    return angle;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/library');
        break;
      case 2:
        Navigator.pushNamed(context, '/schedule');
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _hasPermissions
          ? _buildCompass()
          : _buildPermissionSheet(),
      bottomNavigationBar: MyBottomNavigationBar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }

  Widget _buildCompass() {
    if (_direction == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_qiblaAngle == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Mengambil lokasi...'),
            SizedBox(height: 12),
            CircularProgressIndicator(),
          ],
        ),
      );
    }

    // Sudut rotasi kompas (device) dalam radian, negatif supaya kompas berputar searah jarum jam sesuai heading
    final deviceRotation = (_direction! * (math.pi / 180) * -1);

    // Sudut rotasi panah Qibla, hitung selisih antara arah Qibla dan heading device, lalu ubah ke radian negatif agar panah mengarah benar
    final qiblaRotation = ((_qiblaAngle! - _direction!) * (math.pi / 180) * -1);

    return Center(
      child: NeuCircle(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Gambar kompas berputar sesuai heading device
            Transform.rotate(
              angle: deviceRotation,
              child: Image.asset(
                'assets/compass.png',
                color: Colors.white,
                fit: BoxFit.fill,
                width: 250,
                height: 250,
              ),
            ),
            // Panah merah menunjuk ke arah Qibla relatif terhadap kompas
            Transform.rotate(
              angle: qiblaRotation,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.redAccent,
                size: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Request Location Permission'),
        onPressed: () async {
          await Permission.locationWhenInUse.request();
          _checkPermissionsAndGetLocation();
        },
      ),
    );
  }
}
