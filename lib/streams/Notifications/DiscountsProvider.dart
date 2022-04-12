import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Notifications.dart';

class DiscountsProvider extends ChangeNotifier {
  BehaviorSubject _discounts = BehaviorSubject.seeded([]);

  final _notificationsStreamController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get notificationsStream => _notificationsStreamController.stream;

  dynamic get current => _discounts.value;

  fetchDiscounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");
    int discountsLength = prefs.getInt('discountsLength');

    if (user == null) {
      _discounts.add([]);
      return;
    }

    dynamic methodsData = await getDiscounts();

    _discounts.add(methodsData);

    // print('Local notifications length: ${prefs.getInt('discountsLength')}');
    // print('API notifications length: ${_discounts.value.length ?? 0}');

    if (discountsLength == null) {
      prefs.setInt('discountsLength', _discounts.value?.length ?? 0);
    } else if (_discounts.value?.length != null && discountsLength < _discounts.value?.length) {
      _notificationsStreamController.sink.add(_discounts.value);
      prefs.setInt('discountsLength', _discounts.value?.length);
    } else if (_discounts.value?.length != null){
      prefs.setInt('discountsLength', _discounts.value.length);
    }
  }

  void dispose() {
    _notificationsStreamController?.close();
  }
}