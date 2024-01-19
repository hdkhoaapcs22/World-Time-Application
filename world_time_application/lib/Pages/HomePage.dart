import 'package:flutter/material.dart';

class HOME extends StatefulWidget {
  const HOME({super.key});

  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: <Widget>[
        TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/location');
          },
          icon: const Icon(Icons.edit_location),
          label: const Text("Edit Location"),
        ),
      ]),
    ));
  }
}
