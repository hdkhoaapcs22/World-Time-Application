import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // location name for the UI
  late String time; // the time in that location
  late String url; // location url for api endpoint
  late String flag; // url to an asset flag icon
  bool isDaytime = true; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      http.Response response = await http
          .get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];

      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 18.0 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'could not get time data';
    }
  }
}
