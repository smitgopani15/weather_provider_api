import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screen/home/modal/home_modal.dart';

class ApiHelper {
  Future<WeatherModel?> weatherApiCall(String search) async {
    var response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$search&appid=1177b1e3edcc54bc767e02d9b9806249",
      ),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return WeatherModel.fromJson(json);
    } else {
      return null;
    }
  }
}