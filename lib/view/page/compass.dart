import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:muslim_app_hideri/view/page/neu_circle.dart';
import 'package:muslim_app_hideri/view/widget/navbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class CompassPage extends StatefulWidget {
  @override
  _CompassPageState createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  int _selectedIndex = 3;
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    _fetchPermissionsStatus();
  }

  void _fetchPermissionsStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermissions = status == PermissionStatus.granted;
        });
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi ke halaman terkait jika perlu, misalnya:
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
      body: Builder(
        builder: (context) {
          if (_hasPermissions) {
            return _buildCompass();
          } else {
            return _buildPermissionSheet();
          }
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        return NeuCircle(
          child: Transform.rotate(
            angle: (direction * (math.pi / 180) * -1),
            child: Image.asset(
              'assets/compass.png',
              color: Colors.white,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Request Permissions'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((ignored) {
            _fetchPermissionStatus();
          });
        },
      ),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }
}
