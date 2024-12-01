import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polylines extends StatefulWidget {
  const Polylines({super.key});

  @override
  State<Polylines> createState() => _PolylinesState();
}

class _PolylinesState extends State<Polylines> {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.6708969, 85.3378045),
    zoom: 15.4746,
  );

  final Set<Marker> _marker={};
  final Set<Polyline> _polylines={};

  List<LatLng> _latlng=[
    LatLng(27.672547, 85.337838),
    LatLng(27.680956, 85.323813),
    LatLng(27.690458, 85.336208),
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i=0;i < _latlng.length;i++){
      _marker.add(
          Marker(
              markerId: MarkerId(i.toString()),
            position: _latlng[i],
            icon: BitmapDescriptor.defaultMarker,
          )
      );

      _polylines.add(
        Polyline(
          polylineId: PolylineId(i.toString()),
          points:_latlng,
        ) ,
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:_kGooglePlex,
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        compassEnabled: true,
        polylines: _polylines,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
