import 'package:flutter/material.dart';
import '../Services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // this function helps us to get the time from the world time api
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Ho Chi Minh',
        flag: 'VietnamFlag.jpg',
        url: 'Asia/Ho_Chi_Minh');
    await instance.getTime();
    // it helps us to navigate to the home page
    // the arguments is a map and it helps us to pass data to the home page
    // we pass the data to home page because we want to display the data on the home page
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'dailyTime': instance.dailyTime
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.blue,
          size: 80.0,
        ),
      ),
    );
  }
}
