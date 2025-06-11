import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/provider/location_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class PlacePickerDialog extends StatefulWidget {
  @override
  _PlacePickerDialogState createState() => _PlacePickerDialogState();
}

class _PlacePickerDialogState extends State<PlacePickerDialog> {
  LatLng? selectedLocation;
  String? placeName;

  Future<void> _getPlaceName(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          placeName =
              "${placemark.street}, ${placemark.locality}, ${placemark.country}";
        });
        print(placeName);
      }
    } catch (e) {
      print('Error getting place name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Consumer<LocationProvider>(
          builder: (context, locationProvider, child) {
            return StreamBuilder<Position>(
              stream: locationProvider.positionStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No location data available'));
                } else {
                  Position position = snapshot.data!;
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              FlutterMap(
                                options: MapOptions(
                                  initialCenter: LatLng(
                                      position.latitude, position.longitude),
                                  maxZoom: 13.0,
                                  onTap: (tapPosition, point) {
                                    setState(() {
                                      selectedLocation = point;
                                      placeName = null; // Reset place name
                                    });
                                    _getPlaceName(point);
                                  },
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c'],
                                  ),
                                  if (selectedLocation != null)
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          width: 80.0,
                                          height: 80.0,
                                          point: selectedLocation!,
                                          child: Container(
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                              size: 40.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Pick a location",
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  onPressed: selectedLocation != null ?() {
                                    print(placeName);
                                      Navigator.of(context)
                                          .pop(placeName);
                                    
                                  }: null,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                          40)),
                                  child: Text(
                                    "Confirm",
                                    style:
                                        GoogleFonts.ubuntu(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
