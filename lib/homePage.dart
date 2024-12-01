import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

 Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.6708969, 85.3378045),
    zoom: 18.4746,
  );

  List<Marker> _marker=[];
  List<Marker> _list=const [
    Marker(
        markerId: MarkerId('1'),
        position:LatLng(27.6708969, 85.3378045),
    )
 ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
        initialCameraPosition:_kGooglePlex,
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: ()async{
          GoogleMapController controller= await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target:LatLng(27.67217412980908, 85.4277984600119),
                    zoom: 18
              )
          ));
          setState(() {

          });
        },
      ),

    );
  }
}
