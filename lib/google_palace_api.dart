import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;

class GooglePalaceApi extends StatefulWidget {
  const GooglePalaceApi({super.key});

  @override
  State<GooglePalaceApi> createState() => _GooglePalaceApiState();
}

class _GooglePalaceApiState extends State<GooglePalaceApi> {

  TextEditingController _controller=TextEditingController();
  var uuid=Uuid();
  String _sessionToken='123456';
  List<dynamic> _placesList=[];
  @override


  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener((){
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken==null)
      {
        setState(() {
          _sessionToken=uuid.v4();
        });
      }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY='AIzaSyBjuX8D5sYYOLCVpFDJQAgykBptCoSpRJ8';
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response=await http.get(Uri.parse(request));
    var data =response.body.toString();

    print(data);
    if(response.statusCode==200){
      setState(() {
        _placesList=jsonDecode(response.body.toString()) ['predictions'];
      });
    }
    else{
      throw Exception('error in api response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('google search'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
               hintText: 'search a place'
              ),
            ),
          ),
          Expanded(
              child:ListView.builder(
                  itemCount: _placesList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      onTap: ()async{
                        List<Location> locations = await locationFromAddress(_placesList[index]['description']);
                        print(locations.last.longitude);
                        print(locations.last.latitude);
                      },
                      title: Text(_placesList[index]['description']),
                    );
                  }
              )
          )
        ],
      ),
    );
  }
}
