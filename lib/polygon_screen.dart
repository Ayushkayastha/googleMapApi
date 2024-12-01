import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {

  Completer<GoogleMapController> _controller=Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target:LatLng(27.672547, 85.337838),
    zoom: 18.4746,
  );

  Set<Polygon> _polygon=HashSet<Polygon>();

  List<LatLng> points=[
    LatLng(27.672547, 85.337838),
    LatLng(27.680956, 85.323813),
    LatLng(27.690458, 85.336208),
    LatLng(27.672547, 85.337838),
  ];

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _polygon.add(
      Polygon(
        polygonId: PolygonId('1'),
        points: points,
        fillColor: Colors.redAccent.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 4,
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('polygon'),),
      body: GoogleMap(
        initialCameraPosition:_kGooglePlex,
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
