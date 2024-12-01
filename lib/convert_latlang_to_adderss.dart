import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatlangToAdderss extends StatefulWidget {
  const ConvertLatlangToAdderss({super.key});

  @override
  State<ConvertLatlangToAdderss> createState() => _ConvertLatlangToAdderssState();
}

class _ConvertLatlangToAdderssState extends State<ConvertLatlangToAdderss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              try {
                print('Converting address tocoordinates...');

                String address='F28, Bhaktapur, Nepal';
                var results = await locationFromAddress(address);
                print(results);

                print('Converting coordinates to address...');
                // Replace with your coordinates
                List<Placemark> placemarks = await placemarkFromCoordinates(27.6748,85.4274);
                Placemark place = placemarks[0];
                print("Address: ${place.street}, ${place.locality}, ${place.country}");
              } catch (e) {
                print("Error occurred: $e");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: const Center(
                  child: Text('Convert'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
