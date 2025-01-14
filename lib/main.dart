import 'package:flutter/material.dart';

import 'widgets/google_map_Item.dart';

void main() {
  runApp(const TestGoogleMap());
}

class TestGoogleMap extends StatelessWidget {
  const TestGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GoogleMapItem(),
    );
  }
}
