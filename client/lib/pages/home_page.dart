import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  mp.MapboxMap? mapboxMapController;
  StreamSubscription<gl.Position>? userPositionStream;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mp.MapWidget(
        onMapCreated: _onMapCreated,
      ),
    );
  }

  // Hàm kiểm tra quyền truy cập vị trí
  Future<void> _checkLocationPermission() async {
    gl.LocationPermission permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        debugPrint("Quyền vị trí bị từ chối");
        return;
      }
    }
    if (permission == gl.LocationPermission.deniedForever) {
      debugPrint("Quyền vị trí bị từ chối vĩnh viễn");
      return;
    }
  }

  // Khởi tạo Map
  void _onMapCreated(mp.MapboxMap controller) {
    setState(() {
      mapboxMapController = controller;
    });

    // Kiểm tra quyền trước khi bật vị trí trên bản đồ
    _checkLocationPermission().then((_) {
      mapboxMapController?.location.updateSettings(
        mp.LocationComponentSettings(enabled: true, pulsingEnabled: true),
      );
    });

    // Bắt đầu theo dõi vị trí người dùng
    _setupPositionTracking();
  }

  // Theo dõi vị trí người dùng và cập nhật camera
  void _setupPositionTracking() async {
    bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Dịch vụ định vị đã bị tắt.');
      return;
    }

    gl.LocationPermission permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied ||
        permission == gl.LocationPermission.deniedForever) {
      debugPrint('Quyền vị trí bị từ chối.');
      return;
    }

    // Cài đặt thông số vị trí
    gl.LocationSettings locationSettings = const gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 10, // Cập nhật vị trí mỗi 10m
    );

    // Lắng nghe vị trí và cập nhật camera
    userPositionStream =
        gl.Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((gl.Position position) {
      _updateCameraPosition(position);
    });

    // Lấy vị trí hiện tại ngay khi mở app
    gl.Position position = await gl.Geolocator.getCurrentPosition();
    _updateCameraPosition(position);
  }

// Cập nhật camera với animation mượt mà
  void _updateCameraPosition(gl.Position position) {
    if (mapboxMapController != null) {
      mapboxMapController!.flyTo(
        mp.CameraOptions(
          center: mp.Point(
            coordinates: mp.Position(position.longitude, position.latitude),
          ),
          zoom: 12.0,
        ),
        mp.MapAnimationOptions(duration: 1000, startDelay: 0), // Animation 1s
      );
    }
  }
}
