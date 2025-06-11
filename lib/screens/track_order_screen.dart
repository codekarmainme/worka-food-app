import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:food_app/provider/location_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class TrackOrderScreen extends StatefulWidget {
  final num orderId;
  TrackOrderScreen({required this.orderId});
  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  Position? currentPosition;
  List<LatLng> routePoints = [];
  Future<void> _determinePosition(BuildContext context) async {
    print("object");
    currentPosition =
        await Provider.of<LocationProvider>(context, listen: false)
            .determinePosition(context);
    print(currentPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<LocationProvider>(builder: (context, locationProvider, child) {
      return StreamBuilder<Position>(
          stream: locationProvider.positionStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: _trackordersShimmer());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No location data available'));
            } else {
              Position position = snapshot.data!;
              Position fixedPosition = Position(
                latitude: 9.0256699,
                longitude: 38.7998882,
                timestamp: DateTime.now(),
                altitudeAccuracy: position.altitudeAccuracy,
                headingAccuracy: position.headingAccuracy,
                accuracy: 0,
                altitude: 0,
                heading: 0,
                speed: 0,
                speedAccuracy: 0,
              );
              double distance =
                  locationProvider.calculateDistance(position, fixedPosition);
              LatLng start = LatLng(position.latitude, position.longitude);
              LatLng end = LatLng(9.0256699, 38.7998882);

              locationProvider.getRoute(start, end).then((points) {
                if (mounted) {
                  setState(() {
                    routePoints = points;
                  });
                }
              });
              
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter:
                                  LatLng(position.latitude, position.longitude),
                              maxZoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(fixedPosition.latitude,
                                        fixedPosition.longitude),
                                    child: Container(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.blue,
                                            size: 40.0,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Text(
                                              'You',
                                              style: GoogleFonts.urbanist(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(
                                        position.latitude, position.longitude),
                                    child: Container(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart_rounded,
                                            color: primaryColor,
                                            size: 40.0,
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Text(
                                              'Your food',
                                              style: GoogleFonts.urbanist(
                                                color: primaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  )),
                                ],
                              ),
                              if (routePoints.isNotEmpty)
                                PolylineLayer(
                                  polylines: [
                                    Polyline(
                                      points: routePoints,
                                      strokeWidth: 4.0,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _determinePosition(context);
                            },
                            child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 179, 224, 222),
                                    border: Border.all(
                                        width: 1, color: secondaryColor),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Werka coffee house",
                                        style: GoogleFonts.urbanist()))),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Order #${widget.orderId.toString()}",
                                  style: GoogleFonts.urbanist(fontWeight: FontWeight.bold,color:secondaryColor)),
                              Text(
                                  "${(distance / 1000).toStringAsFixed(2)} km away",
                                  style: GoogleFonts.urbanist(fontWeight: FontWeight.bold,color:secondaryColor)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: secondaryColor),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                  child: Text("Delivering",
                                      style: GoogleFonts.urbanist())),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          });
    }));
  }
  
  Widget _trackordersShimmer() {
    
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(8.0),
              child: Column(
               children:[
                Container(
                  height: MediaQuery.of(context).size.height*0.8,
                    decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10))
                ),
             
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20,
                      width: 120,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 179, 224, 222),
                        border: Border.all(
                            width: 1, color: secondaryColor),
                        borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left:8.0,right:8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          color:Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            color:Colors.grey[300],
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      )
                    ],
                    
                  ),
                ),
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                     color:Colors.grey[300],
                    borderRadius: BorderRadius.circular(25)
                  ),
                )
               ]
               
              ),
            ),
          ),
        );
      
    
  }
}
