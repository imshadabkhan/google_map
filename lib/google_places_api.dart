import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

//Getting data from  google places apis and showing on frontend!/////


class Google_Places_Apis_Screen extends StatefulWidget {
  const Google_Places_Apis_Screen({super.key});

  @override
  State<Google_Places_Apis_Screen> createState() => _Google_Places_Apis_ScreenState();
}

class _Google_Places_Apis_ScreenState extends State<Google_Places_Apis_Screen> {
  TextEditingController _controller=TextEditingController();
  String tokken="123456";
  var uuid=Uuid();
  String Apikey="AIzaSyDFCTAIhg4KhIKgD0L0IqYdA86CUbFMzQw";
  List<dynamic> _placeList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();

    });



  }

  onChange(){
    if(tokken==null){
      tokken=uuid.v4();
    }
    setState(() {

    });
    getSuggestion(_controller.text);

  }

  void getSuggestion(String input)async{
    String Apikey="AIzaSyDFCTAIhg4KhIKgD0L0IqYdA86CUbFMzQw";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$Apikey&sessiontoken=$tokken';
    var response= await http.get(Uri.parse(request));
  debugPrint(response.body.toString());
    if(response.statusCode==200){
        _placeList=jsonDecode(response.body.toString()) ['predictions'];
    }else{
      throw Exception("Failed to load data");
    }




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google PlacesApis"),centerTitle: true,),
      body: Column(children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "search here",
         border: OutlineInputBorder(),

          ),
        ),
        Expanded(child: ListView.builder(itemCount:_placeList.length,itemBuilder: (context,index){
          return ListTile(title: Text(_placeList[index]['description']),onTap: ()async{
            List<Location> location=await locationFromAddress(_placeList[index]['description']);
            debugPrint(location.last.latitude.toString());
            debugPrint(location.last.longitude.toString());



          },);


        }))
      ],),
    );
  }
}
