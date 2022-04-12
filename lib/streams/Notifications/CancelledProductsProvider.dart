import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Notifications.dart';

class CancelledProductsProvider extends ChangeNotifier {
  BehaviorSubject _cancelledProducts = BehaviorSubject.seeded([]);

  final _notificationsStreamController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get notificationsStream => _notificationsStreamController.stream;

  dynamic get current => _cancelledProducts.value;

  fetchCancelledProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");
    int cancelledProductsLength = prefs.getInt('cancelledProductsLength');

    if (user == null) {
      _cancelledProducts.add([]);
      return;
    }

    dynamic methodsData = await getCancelledProducts();

    _cancelledProducts.add(methodsData);

    // print('Local notifications length: ${prefs.getInt('cancelledProductsLength')}');
    // print('API notifications length: ${_cancelledProducts.value.length ?? 0}');

    if (cancelledProductsLength == null) {
      prefs.setInt('cancelledProductsLength', _cancelledProducts.value?.length ?? 0);
    } else if (_cancelledProducts.value?.length != null && cancelledProductsLength < _cancelledProducts.value?.length) {
      _notificationsStreamController.sink.add(_cancelledProducts.value);
      prefs.setInt('cancelledProductsLength', _cancelledProducts.value?.length);
    } else if(_cancelledProducts.value?.length != null) {
      prefs.setInt('cancelledProductsLength', _cancelledProducts.value?.length ?? 0);
    }
  }

  void dispose() {
    _notificationsStreamController?.close();
  }
}