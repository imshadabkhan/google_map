import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polygone_Screen extends StatefulWidget {
  const Polygone_Screen({super.key});

  @override
  State<Polygone_Screen> createState() => _Polygone_ScreenState();
}

class _Polygone_ScreenState extends State<Polygone_Screen> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(33.987535, 71.537840),
      infoWindow: InfoWindow(title: "My Location"),
    ),
  ];
  List _coordinates = [LatLng(33.987535, 71.537840)];
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(33.987535, 71.537840),
  );
  Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> _points = [
    LatLng(33.987535, 71.537840),
    LatLng(34.091220, 71.218953),
    LatLng(34.475705, 71.330386),
    LatLng(
      34.217935,
      70.317796,
    ),
    LatLng(
      32.739857,
      70.184634,
    ),
    LatLng(33.987535, 71.537840)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(Polygon(
        points: _points,
        polygonId: PolygonId('1'),
        fillColor: Colors.red.withOpacity(0.5),
        strokeWidth: 10,
        strokeColor: Colors.orange));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        compassEnabled: true,
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
