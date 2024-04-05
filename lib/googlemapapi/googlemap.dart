import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _kathmandu =
      LatLng(27.7172, 85.3240); // Kathmandu coordinates

  static const LatLng _dustbin1 =
      LatLng(27.7098, 85.3253); // Dummy dustbin 1 location
  static const LatLng _dustbin2 =
      LatLng(27.6938, 85.3221); // Dummy dustbin 2 location
  static const LatLng _dustbin3 =
      LatLng(27.7241, 85.3096); // Dummy dustbin 3 location

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getPolylinePoints().then((coordinates) {
      generatePolyLineFromPoints(coordinates);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: ((GoogleMapController controller) =>
            _mapController.complete(controller)),
        initialCameraPosition: const CameraPosition(
          target: _kathmandu,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("_dustbin1"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: _dustbin1,
            infoWindow: const InfoWindow(title: 'Dustbin 1'),
          ),
          Marker(
            markerId: const MarkerId("_dustbin2"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: _dustbin2,
            infoWindow: const InfoWindow(title: 'Dustbin 2'),
          ),
          Marker(
            markerId: const MarkerId("_dustbin3"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            position: _dustbin3,
            infoWindow: const InfoWindow(title: 'Dustbin 3'),
          ),
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyD9GUN6NoQ_ldV5gTWSsKsfAjwJ61Xbq7Q',
      PointLatLng(
          _kathmandu.latitude, _kathmandu.longitude), // Source: Kathmandu
      PointLatLng(_dustbin1.latitude,
          _dustbin1.longitude), // Destination: Dummy dustbin 1
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
