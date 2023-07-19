import 'package:flutter/material.dart';
import 'package:googlemaps/adding_custom_markers.dart';
import 'package:googlemaps/conversion.dart';
import 'package:googlemaps/custom_info_window.dart';
import 'package:googlemaps/google_places_api.dart';
import 'package:googlemaps/ploygone_screen.dart';
import 'package:googlemaps/polyline.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Polyline_Screen(),
    );
  }
}
