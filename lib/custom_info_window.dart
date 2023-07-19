import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Custom_Info_Window extends StatefulWidget {
  const Custom_Info_Window({super.key});

  @override
  State<Custom_Info_Window> createState() => _Custom_Info_WindowState();
}

class _Custom_Info_WindowState extends State<Custom_Info_Window> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  List<Marker> _markers = [];
  List<LatLng> _coordinates = [
    LatLng(33.987535, 71.537840),
    LatLng(32.987535, 70.537840),
    LatLng(31.987535, 69.537840),
    LatLng(30.987535, 68.537840),
    LatLng(29.987535, 67.537840),
    LatLng(28.987535, 66.537840),
  ];
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(33.987535, 71.537840), zoom: 15);
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId('1'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(33.987535, 71.537840),
        infoWindow: InfoWindow(title: "My Location")));
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _coordinates.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _coordinates[i],
          icon: BitmapDescriptor.defaultMarker,
          onTap: (){
            _customInfoWindowController.addInfoWindow!(
             Container(height: 300,
               width: 300,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
               child: Column(

               children: [
               Container(height:100,width:300,decoration: BoxDecoration(color: Colors.red,image: DecorationImage(image:AssetImage('assets/images/resturant.jpg'),fit: BoxFit.fill,filterQuality: FilterQuality.medium)),),
               Text("Resturantoos"),

             ],),),_coordinates[i],
            );
            setState(() {

            });
          }
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onTap: (position){
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove:(position){_customInfoWindowController.onCameraMove!();},
            compassEnabled: true,
            markers: Set<Marker>.of(_markers),
            initialCameraPosition: _cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;

            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 150,
            width: 150,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
