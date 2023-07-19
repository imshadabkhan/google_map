import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
 //we have integrated the google map we have put markers on the particular coordinates and we have also use the concep og googleAnimationCamera etc;
class _HomeState extends State<Home> {
  List<Marker> _markers = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.987535, 71.537840),
      infoWindow: InfoWindow(title: "Shadab house"),
    ),
    Marker(markerId: MarkerId('2'), position: LatLng(34.001238, 71.544814),infoWindow: InfoWindow(title: 'Deans Trade Center'),),
    Marker(markerId: MarkerId("3"),position: LatLng(49.282366, -123.120975),infoWindow: InfoWindow(title: "some where in vancouver canda hehehuhu"))

  ];
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _positionCamera = CameraPosition(
      target: LatLng(
        33.987535,
        71.537840,
      ),
      zoom: 14);


  @override
  void initState() {
    // TODO: implement initState
    _markers.addAll(_list);
    super.initState();
  }

  Future<Position> getUserCurrentLocation()async{
   await Geolocator.requestPermission().then((value) => null).onError((error, stackTrace)async{
     await Geolocator.requestPermission();
     debugPrint(error.toString());

   }

   );
   return await Geolocator.getCurrentPosition();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child:Icon(Icons.location_on_outlined,color:  Colors.black,),
          onPressed: ()async{
        // GoogleMapController controller=await _controller.future;
        // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(49.282366, -123.120975),zoom: 14 ),),);

        getUserCurrentLocation().then((value) async{
          debugPrint(value.longitude.toString());
          debugPrint(value.latitude.toString());
          _markers.add(Marker(markerId: MarkerId('4'),infoWindow: InfoWindow(title: "Users current location"),position: LatLng(value.longitude,value.latitude)));
          CameraPosition cameraPosition=CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 14);
          final GoogleMapController controller= await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {

          });

        });

          },),
      body: SafeArea(
        child: GoogleMap(
          compassEnabled: true,
          markers: Set<Marker>.of(_markers),
          initialCameraPosition: _positionCamera,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
