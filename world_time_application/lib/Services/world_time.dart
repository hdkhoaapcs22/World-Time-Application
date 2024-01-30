import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

enum Daytime { sunrise, morning, sunset, night }

class WorldTime {
  late String location; // location name for the UI
  late String time; // the time in that location
  late String url; // location url for api endpoint
  late String flag; // url to an asset flag icon
  late Daytime dailyTime;
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

      if (now.hour >= 5 && now.hour <= 6) {
        dailyTime = Daytime.sunset;
      } else if (now.hour > 6 && now.hour < 17) {
        dailyTime = Daytime.morning;
      } else if (now.hour >= 17 && now.hour <= 18) {
        dailyTime = Daytime.sunset;
      } else {
        dailyTime = Daytime.night;
      }
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'could not get time data';
    }
  }

  factory WorldTime.fromJson(Map<String, dynamic> json) {
    return WorldTime(
        location: json['location'], flag: json['flag'], url: json['url']);
  }
}
