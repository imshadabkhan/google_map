import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConversionOfCoordinateToAddressAndAddressToCoordinates
    extends StatefulWidget {
  @override
  _ConversionOfCoordinateToAddressAndAddressToCoordinatesState createState() =>
      _ConversionOfCoordinateToAddressAndAddressToCoordinatesState();
}

class _ConversionOfCoordinateToAddressAndAddressToCoordinatesState
    extends State<ConversionOfCoordinateToAddressAndAddressToCoordinates> {
  String? result;
  bool isConverted = false;
  double latitude = 34.001238;
  double longitude = 71.544814;

  Future<void> convertCoordinatesToAddress() async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          result =
          'Address: ${placemark.street}, ${placemark.locality}, ${placemark.country}';
          isConverted = true;
        });
      } else {
        setState(() {
          result = 'No address found for the given coordinates.';
          isConverted = true;
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
        isConverted = true;
      });
    }
  }

  Future<void> convertAddressToCoordinates() async {
    try {
      List<Location> locations = await locationFromAddress(
          '1600 Amphitheatre Parkway, Mountain View, CA');
      if (locations.isNotEmpty) {
        Location location = locations.first;
        setState(() {
          result =
          'Latitude: ${location.latitude}, Longitude: ${location.longitude}';
          isConverted = true;
        });
      } else {
        setState(() {
          result = 'No coordinates found for the given address.';
          isConverted = true;
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
        isConverted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              result ?? '',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                if (!isConverted) {
                  convertCoordinatesToAddress();
                }
              },
              child: Text('Convert Coordinates to Address'),
            ),
            ElevatedButton(
              onPressed: () {
                if (!isConverted) {
                  convertAddressToCoordinates();
                }
              },
              child: Text('Convert Address to Coordinates'),
            ),
          ],
        ),
      ),
    );
  }
}
