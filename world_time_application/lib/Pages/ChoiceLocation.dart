import 'package:flutter/material.dart';
import '../Services/world_time.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  // we create a list of world time objects
  // List<WorldTime> locations = [
    // WorldTime(
    //     url: 'Asia/Ho_Chi_Minh',
    //     location: 'Ho Chi Minh',
    //     flag: 'VietnamFlag.jpg'),
    // WorldTime(
    //     url: 'America/Havana', location: 'La Habana', flag: 'CubaFlag.jpg'),
    // WorldTime(url: 'Europe/Moscow', location: 'Moscow', flag: 'RussiaFlag.jpg'),
    // WorldTime(url: 'Asia/Thimphu', location: 'Thimphu', flag: 'BhutanFlag.jpg'),
    // WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'EgyptFlag.jpg'),
    // WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'JapanFlag.jpg'),
    // WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'KoreaFlag.jpg'),
    // WorldTime(url: 'Asia/Tehran', location: 'Tehran', flag: 'IranFlag.jpg'),
    // WorldTime(url: 'Europe/London', location: 'London', flag: 'UKFlag.jpg'),
    // WorldTime(
    //     url: 'Asia/Hong_Kong',
    //     location: 'Hong Kong',
    //     flag: 'Hong_KongFlag.jpg'),
    // WorldTime(
    //     url: 'America/New_York', location: 'New York', flag: 'USAFlag.jpg'),
  // ];

  void loadData(locations) async {
    // we read the data from the file
    var data = await rootBundle.loadString('assets/data/data.txt');
    // we split the data into a list of strings
    List<String> tmp = data.split('\n');
    // we loop through the list of strings
    for (var location in tmp) {
      // we split each string into a list of strings
      List<String> locationData = location.split(', ');
      // we create a new WorldTime object and add it to the list of locations
      locations.add(WorldTime(
          url: locationData[0],
          location: locationData[1],
          flag: locationData[2]));
    }
   for(int i=0;i<locations.length;++i)
  { print(locations[i]);
  }
  }

  void updateTime(index, locations) async {
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
    List<WorldTime> locations = [];
    loadData(locations);
    // var data = await rootBundle.loadString('assets/data/data.txt');
    // List<String> locations = data.split('\n');
    // for (var location in locations) {
    //   List<String> locationData = location.split(', ');
    //   this.locations.add(WorldTime(
    //       url: locationData[0],
    //       location: locationData[1],
    //       flag: locationData[2]));
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 2, 42, 110),
          title: const Text("Choose Location"),
          centerTitle: true,
        ),
        body: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          thickness: 8.0,
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                    child: ListTile(
                  onTap: () {
                    updateTime(index,locations);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/${locations[index].flag}'),
                  ),
                )),
              );
            },
          ),
        ));
  }
}
