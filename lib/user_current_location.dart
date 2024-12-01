import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {

  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.6708969, 85.3378045),
    zoom: 18.4746,
  );

  List<Marker> _marker=[];
  List<Marker> _list= [
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

  Future<Position> getUserLocation()async{

    await Geolocator.requestPermission().then(
            (value){
              
    }).onError((error,stackTrace){
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      GoogleMap(
        initialCameraPosition:_kGooglePlex,
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
        getUserLocation().then((value) async {
          print('my current location');
           print(value.latitude.toString()+''+value.longitude.toString());
           _marker.add(
             Marker(
               markerId: MarkerId('2'),
               position: LatLng(value.latitude,value.longitude),
             )
           );

          CameraPosition cameraPosition=CameraPosition(
              zoom: 18,
              target:LatLng(value.latitude,value.longitude)
          );

          final GoogleMapController controller= await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {

          });


        });
            },
        child:Icon(Icons.pin_drop),
      ),
    );
  }
}
