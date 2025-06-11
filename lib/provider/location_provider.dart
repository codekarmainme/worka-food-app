import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

class LocationProvider extends ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  Stream<Position> get positionStream => Geolocator.getPositionStream();
  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request users to enable the location services.
      await _showLocationServiceDialog(context);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } // When we reach here, permissions are granted and we can continue accessing the position of the device.
    _currentPosition = await Geolocator.getCurrentPosition();
    notifyListeners();
    return _currentPosition!;
  }

  double calculateDistance(Position start, Position end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final apiKey = '5b3ce3597851110001cf624823d7764e2ff94c3ba1ac8735df2e0238';
    final url =
        'https://api.openrouteservice.org/v2/directions/foot-walking?api_key=$apiKey&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}';
                                                                                     
    int retryCount = 0;
    const maxRetries = 3;
    const retryDelay = Duration(seconds: 2);

    while (retryCount < maxRetries) {
      try {
        // Delay before making the request to avoid exceeding the rate limit
        await Future.delayed(Duration(seconds: 2));

        final response = await Dio().get(url);

        if (response.statusCode == 200) {
          final data = response.data;
          final coordinates = data['features'][0]['geometry']['coordinates'];
          return coordinates
              .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
              .toList();
        } else {
          throw Exception('Failed to load route');
        }
      } catch (e) {
        if (e is DioError) {
          if (e.response?.statusCode == 429) {
            final retryAfter = e.response?.headers['retry-after']?.first ?? '2';
            final waitTime = int.tryParse(retryAfter) ?? 2;
            retryCount++;
            if (retryCount < maxRetries) {
              await Future.delayed(Duration(seconds: waitTime));
            } else {
             
              return [];
            }
          } else if (e.response?.statusCode == 403) {
            print(
                'Failed to load route: Invalid API key or insufficient permissions');
            return [];
          } else {
            
            return [];
          }
        } else {
         
          return [];
        }
      }
    }

    return [];
  }

  Future<void> _showLocationServiceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Services Disabled'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enable location services to continue.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
