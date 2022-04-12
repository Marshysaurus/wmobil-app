import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Notifications.dart';

class CancelledAccountsProvider extends ChangeNotifier {
  BehaviorSubject _cancelledAccounts = BehaviorSubject.seeded([]);

  final _notificationsStreamController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get notificationsStream => _notificationsStreamController.stream;

  dynamic get current => _cancelledAccounts.value;

  fetchCancelledAccounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");
    int cancelledAccountsLength = prefs.getInt('cancelledAccountsLength');

    if (user == null) {
      _cancelledAccounts.add([]);
      return;
    }

    dynamic methodsData = await getCancelledAccounts();

    _cancelledAccounts.add(methodsData);

    // print('Local notifications length: ${prefs.getInt('cancelledAccountsLength')}');
    // print('API notifications length: ${_cancelledAccounts.value?.length ?? 0}');

    if (cancelledAccountsLength == null) {
      prefs.setInt('cancelledAccountsLength', _cancelledAccounts.value?.length ?? 0);
    } else if (_cancelledAccounts.value?.length != null && cancelledAccountsLength < _cancelledAccounts.value?.length) {
      _notificationsStreamController.sink.add(_cancelledAccounts.value);
      prefs.setInt('cancelledAccountsLength', _cancelledAccounts.value?.length);
    } else if (_cancelledAccounts.value?.length != null) {
      prefs.setInt('cancelledAccountsLength', _cancelledAccounts.value?.length ?? 0);
    }
  }

  void dispose() {
    _notificationsStreamController?.close();
  }
}