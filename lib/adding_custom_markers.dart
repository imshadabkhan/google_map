import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Adding_Custom_Markers extends StatefulWidget {
  const Adding_Custom_Markers({super.key});

  @override
  State<Adding_Custom_Markers> createState() => _Adding_Custom_MarkersState();
}

class _Adding_Custom_MarkersState extends State<Adding_Custom_Markers> {
 List<String> images=['assets/icons/bycicle.png','assets/icons/car.png','assets/icons/school.png'];
 List<String> _title=["BikePoint","CarPoint","School"];
 List<Marker> _marker=[];
 List<LatLng> _latlng=[ LatLng(33.987535, 71.537840), LatLng(35.987535, 74.537840), LatLng(48.987535, 85.537840),];
 final _addlist=[Marker(markerId: MarkerId('1'),infoWindow: InfoWindow(title: "My Location"),position: LatLng(33.987535, 71.537840),)];
 CameraPosition _cameraPosition=CameraPosition(target: LatLng(33.987535, 71.537840));
 Completer <GoogleMapController> _controller=Completer();
 @override

 Uint8List ?imagenetwork;


 Future<Uint8List> getDataFromAssets(String path,int width)async{
   ByteData data=await rootBundle.load(path);
   ui.Codec codec=await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: width);
   ui.FrameInfo fi=await codec.getNextFrame();
   return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();


 }
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_addlist);
    loadData();
  }

  loadData()async{
   for(int i=0;i<images.length;i++){

     final Uint8List markerIcon=await getDataFromAssets(images[i],100);
     _marker.add(Marker(markerId: MarkerId(i.toString()),position: _latlng[i],infoWindow: InfoWindow(title:_title[i].toString() ),icon:BitmapDescriptor.fromBytes(markerIcon),));
   }
   setState(() {

   });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,

        initialCameraPosition: _cameraPosition,
        markers:Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);

        },
      ),

    );
  }
}
