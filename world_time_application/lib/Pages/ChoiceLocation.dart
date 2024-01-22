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
  List<WorldTime> filteredLocations = [];

  @override
  void initState() {
    filteredLocations = locations;
    super.initState();
  }

  void updateTime(index) async {
    WorldTime instance = filteredLocations[index];
    await instance.getTime();
    // pop function helps us to go back to the home page
    // we pass the data to home page because we want to display the data on the home page
    if (context.mounted) {
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime
      });
    }
  }

  void searchingHelper(String userInputString) {
    List<WorldTime> temp = [];
    if (userInputString.isEmpty == true) {
      temp = locations;
    } else {
      temp = locations
          .where((element) => element.location
              .toLowerCase()
              .contains(userInputString.toLowerCase()))
          .toList();
    }

    setState(
      () => filteredLocations = temp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 97, 173),
          title: const Text(
            "Choose Location",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        endDrawer: SizedBox(
            width: 250.0,
            child: Drawer(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListView(padding: EdgeInsets.zero, children: const [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 236, 91, 140),
                      ),
                      child: Center(
                          child: Text(
                        "OPTIONS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      size: 30.0,
                    ),
                    title: Text('Home',
                        style: TextStyle(
                          fontSize: 25.0,
                        )),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.alarm,
                      size: 30.0,
                    ),
                    title: Text('Alarm',
                        style: TextStyle(
                          fontSize: 25.0,
                        )),
                    onTap: null,
                  ),
                ]))),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
          child: Column(children: <Widget>[
            const SizedBox(height: 10.0),
            TextField(
              autocorrect: true,
              onChanged: (unserInputString) =>
                  searchingHelper(unserInputString),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search)),
            ),
            Expanded(
                child: Scrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              interactive: true,
              thickness: 8.0,
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                        child: ListTile(
                      onTap: () {
                        updateTime(index);
                      },
                      title: Text(filteredLocations[index].location),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'lib/assets/${filteredLocations[index].flag}'),
                      ),
                    )),
                  );
                },
              ),
            ))
          ]),
        ));
  }
}
