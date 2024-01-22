import 'package:flutter/material.dart';

class HOME extends StatefulWidget {
  const HOME({super.key});

  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    String backgroundImage =
        data['isDaytime'] ? 'Morning Time.jpg' : 'Night Time.jpg';

    Color? bgColor =
        data['isDaytime'] ? Colors.blue[400] : Colors.indigo[400] as Color;
    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/$backgroundImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 108.0, 0.0, 0.0),
              child: Column(children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    if (result == null) {
                      data = ModalRoute.of(context)!.settings.arguments as Map;
                    } else {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag']
                        };
                      });
                    }
                  },
                  icon: const Icon(Icons.edit_location),
                  label: Text("Edit Location",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: const TextStyle(
                        fontSize: 30.0,
                        letterSpacing: 2.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15.0),
                Text(
                  data['time'],
                  style: const TextStyle(fontSize: 66.0),
                )
              ]),
            ),
          ),
        ));
  }
}
