import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

getUserMethods() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/users/payment",
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

  var methods = jsonData["methods"];
  return methods;
}

addPaymentMethod(String cardToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await post(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/users/payment",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    },
    body: jsonEncode(<String, String>{"token": cardToken}),
  );

  var jsonData = json.decode(response.body);

  if (response.statusCode != 200) {
    // Show an error
    String message = jsonData["message"];

    return message;
  }

  return jsonData;
}
