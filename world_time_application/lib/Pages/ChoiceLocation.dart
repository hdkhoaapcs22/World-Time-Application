import 'package:flutter/material.dart';
import '../Services/world_time.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  // we create a list of world time objects
  List<WorldTime> locations = [];
  List<WorldTime> filteredLocations = [];

  void loadData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final productdata = await json.decode(response);
    var list = productdata["items"] as List<dynamic>;
    setState(() {
      locations = list.map((e) => WorldTime.fromJson(e)).toList();
      filteredLocations = locations;
    });
  }

  @override
  void initState() {
    loadData();
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
        'dailyTime': instance.dailyTime
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
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
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
                            'assets/${filteredLocations[index].flag}'),
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
