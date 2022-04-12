import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

getTable(int tableID, int restaurantID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/tables/$tableID/restaurant/$restaurantID/",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    },
  );

  var jsonData = json.decode(response.body);

  if (response.statusCode != 200) {
    // Show an error
    String message = jsonData["message"];

    return message;
  }

  var table = jsonData["table"];

  return table;
}
