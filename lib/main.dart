import 'package:flutter/material.dart';

import 'widgets/custom_google_map.dart';

void main() {
  runApp(const TestGoogleMap());
}

class TestGoogleMap extends StatelessWidget {
  const TestGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomGoogleMap(),
    );
  }
}
