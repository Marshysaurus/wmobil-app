import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

getUserRestaurants() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/restaurants",
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

  var restaurants = jsonData;

  return restaurants;
}

getUserRestaurant(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/restaurants/$id",
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

  var restaurant = jsonData["restaurant"][0];

  return restaurant;
}

getUserRestaurantHistoricCuts(int id, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$id/corte?start_date=$startDate&end_date=$endDate",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    },
  );

  var jsonData = json.decode(response.body);

  if (response.statusCode != 200) {
    String message = jsonData["message"];
    return message;
  }

  var cuts = jsonData;

  return cuts;
}

getUserRestaurantHistoricMovements(
    int id, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$id/movimientos?start_date=$startDate&end_date=$endDate",
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

  var movements = jsonData;

  return movements;
}

getUserRestaurantHistoricWaiters(
    int id, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$id/meseros?start_date=$startDate&end_date=$endDate",
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

  var waiters = jsonData;

  return waiters;
}

getUserRestaurantHistoricWaiterDeliveries(int restaurantID, int waiterID,
    String startDate, String endDate, String groupProduct) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/meseros/$waiterID?start_date=$startDate&end_date=$endDate&product_group=$groupProduct",
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

  var deliveries = jsonData;

  return deliveries;
}

getUserRestaurantAccountsDiscounts(
    int restaurantID, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/descuento_a_cuentas?start_date=$startDate&end_date=$endDate",
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

  var accounts = jsonData;

  return accounts;
}

getUserRestaurantProductsDiscounts(
    int restaurantID, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/descuento_a_productos?start_date=$startDate&end_date=$endDate",
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

  var products = jsonData;

  return products;
}

getUserRestaurantAccountsCancellations(
    int restaurantID, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/cuentas_canceladas?start_date=$startDate&end_date=$endDate",
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

  var accounts = jsonData;

  return accounts;
}

getUserRestaurantProductsCancellations(
    int restaurantID, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/productos_cancelados?start_date=$startDate&end_date=$endDate",
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

  var accounts = jsonData;

  return accounts;
}

getUserRestaurantProductsInProduction(
    int restaurantID, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/productos_en_produccion?start_date=$startDate&end_date=$endDate",
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

  var accounts = jsonData;

  return accounts;
}

getUserRestaurantAssists(int restaurantID, String startDate, String endDate) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/asistencias?start_date=$startDate&end_date=$endDate",
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

  var assists = jsonData;

  return assists;
}

getUserRestaurantFiscalLogPermission(int restaurantID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/puede_bitacora",
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

  var permission = jsonData;

  return permission;
}

getUserRestaurantFiscalLog(int restaurantID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/historic/restaurants/$restaurantID/bitacora",
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

  var registers = jsonData;

  return registers;
}
