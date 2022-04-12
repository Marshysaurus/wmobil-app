import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic loginUser(String email, String password) async {
  final Response response = await post(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/users/login",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email": email,
      "password": password,
      "isMobile": "true",
    }),
  );

  var jsonData = json.decode(response.body);

  if (response.statusCode != 200) {
    // Show an error
    String message = jsonData["error"]["message"];

    return message;
  }

  String token = jsonData["token"];

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("jwt", token);
}

void logoutUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  await post(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/users/logout",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token",
    },
    body: jsonEncode(<String, String>{"isMobile": "true"}),
  );

  // var jsonData = json.decode(response.body);

  await prefs.clear();
}

getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/users",
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

  var user = jsonData["user"];

  return user;
}
