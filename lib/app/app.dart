import 'package:Noting/app/screens/home/widget.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  static const String _title = "Noting";

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: _title,
        home: HomeScreen(),
      );
}
