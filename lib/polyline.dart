import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Polyline_Screen extends StatefulWidget {
  const Polyline_Screen({super.key});

  @override
  State<Polyline_Screen> createState() => _Polyline_ScreenState();
}

class _Polyline_ScreenState extends State<Polyline_Screen> {
  Completer<GoogleMapController> _controller=Completer();
  final Set<Marker> _marker={};
  List<LatLng> _coordinates=[LatLng(33.987535, 71.537840), LatLng(34.091220, 71.218953),LatLng(34.0086 ,71.4878)];
  final Set<Polyline> _polyline = {};
  CameraPosition _position=CameraPosition(target: LatLng(33.987535, 71.537840),);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   for(int i=0 ; i<_coordinates.length;i++) {
     _marker.add(
         Marker(markerId: MarkerId(i.toString()),position: _coordinates[i],));
   }
   _polyline.add(Polyline(polylineId: PolylineId("1"),points: _coordinates,color: Colors.orangeAccent),);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(initialCameraPosition: _position,compassEnabled: true,mapType: MapType.hybrid,
        polylines: _polyline,

        markers: _marker,
        onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
        },),
    );
  }
}
