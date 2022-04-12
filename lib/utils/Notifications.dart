import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllNotifications extends ChangeNotifier {
  BehaviorSubject _allNotifications = BehaviorSubject.seeded(null);

  Stream get stream$ => _allNotifications.stream;

  dynamic get current => _allNotifications.value;

  areNotificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");
    bool areNotificationsActive = prefs.getBool("allNotificationsActive");

    if (user == null) {
      _allNotifications.add(user);
      return;
    }

    if (areNotificationsActive == null) {
      prefs.setBool("allNotificationsActive", true);
      _allNotifications.add(true);
    } else {
      _allNotifications.add(areNotificationsActive);
    }
  }

  toggleForNotifications(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _allNotifications.add(user);
      return;
    }

    prefs.setBool("allNotificationsActive", newValue);
    _allNotifications.add(newValue);
  }
}

class CancelledProductNotification extends ChangeNotifier {
  BehaviorSubject _notifications = BehaviorSubject.seeded(null);

  Stream get stream$ => _notifications.stream;

  dynamic get current => _notifications.value;

  areNotificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");
    bool areNotificationsActive = prefs.getBool("cpn");

    if (user == null) {
      _notifications.add(user);
      return;
    }

    if (areNotificationsActive == null) {
      prefs.setBool("cpn", true);
      _notifications.add(true);
    } else {
      _notifications.add(areNotificationsActive);
    }
  }

  toggleForNotifications(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _notifications.add(user);
      return;
    }

    prefs.setBool("cpn", newValue);
    _notifications.add(newValue);
  }
}

class CancelledAccountNotification extends ChangeNotifier {
  BehaviorSubject _notifications = BehaviorSubject.seeded(null);

  Stream get stream$ => _notifications.stream;

  dynamic get current => _notifications.value;

  areNotificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");
    bool areNotificationsActive = prefs.getBool("can");

    if (user == null) {
      _notifications.add(user);
      return;
    }

    if (areNotificationsActive == null) {
      prefs.setBool("can", true);
      _notifications.add(true);
    } else {
      _notifications.add(areNotificationsActive);
    }
  }

  toggleForNotifications(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _notifications.add(user);
      return;
    }

    prefs.setBool("can", newValue);
    _notifications.add(newValue);
  }
}

class DiscountNotification extends ChangeNotifier {
  BehaviorSubject _notifications = BehaviorSubject.seeded(null);

  Stream get stream$ => _notifications.stream;

  dynamic get current => _notifications.value;

  areNotificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");
    bool areNotificationsActive = prefs.getBool("dn");

    if (user == null) {
      _notifications.add(user);
      return;
    }

    if (areNotificationsActive == null) {
      prefs.setBool("dn", true);
      _notifications.add(true);
    } else {
      _notifications.add(areNotificationsActive);
    }
  }

  toggleForNotifications(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _notifications.add(user);
      return;
    }

    prefs.setBool("dn", newValue);
    _notifications.add(newValue);
  }
}

getCancelledProducts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/restaurants/all/cancelled_products",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    },
  );

  var jsonData = json.decode(response.body);
  // print(jsonData);

  if (response.statusCode != 200) {
    // Show an error
    String message = jsonData["message"];

    return message;
  }

  var cancelledProducts = jsonData["cancelaciones"];

  return cancelledProducts;
}

getCancelledAccounts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/restaurants/all/cancelled_tables",
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

  var cancelledAccounts = jsonData["cancelaciones"];

  return cancelledAccounts;
}

getDiscounts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("jwt");

  final Response response = await get(
    "https://wmobil-api-dyejt.ondigitalocean.app/api/restaurants/all/discounts",
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

  var discounts = jsonData["descuentos"];

  return discounts;
}