import 'package:flutter/material.dart';
import '../Services/world_time.dart';
import 'dart:io';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  // we create a list of world time objects
  List<WorldTime> locations = [
    WorldTime(
        url: 'Asia/Ho_Chi_Minh',
        location: 'Ho Chi Minh',
        flag: 'Vietnam Flag.jpg'),
    WorldTime(
        url: 'America/Havana', location: 'La Habana', flag: 'Cuba Flag.jpg'),
    WorldTime(
        url: 'Europe/Moscow', location: 'Moscow', flag: 'Russia Flag.jpg'),
    WorldTime(
        url: 'Asia/Thimphu', location: 'Thimphu', flag: 'Bhutan Flag.jpg'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'Egypt Flag.jpg'),
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'Japan Flag.jpg'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'Korea Flag.jpg'),
    WorldTime(url: 'Asia/Tehran', location: 'Tehran', flag: 'Iran Flag.jpg'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'UK Flag.jpg'),
    WorldTime(
        url: 'Asia/Hong_Kong',
        location: 'Hong Kong',
        flag: 'Hong Kong Flag.jpg'),
    WorldTime(
        url: 'America/New_York', location: 'New York', flag: 'USA Flag.jpg'),
  ];
  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // pop function helps us to go back to the home page
    // we pass the data to home page because we want to display the data on the home page
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 2, 42, 110),
          title: const Text("Choose Location"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
          child: Column(children: <Widget>[
            const SizedBox(height: 10.0),
            const TextField(
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                hintText: 'Search',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                        child: ListTile(
                      onTap: () {
                        updateTime(index);
                      },
                      title: Text(locations[index].location),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/assets/${locations[index].flag}'),
                      ),
                    )),
                  );
                },
              ),
            )
          ]),
        ));
  }
}
