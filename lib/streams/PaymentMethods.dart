import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/PaymentMethods.dart';

class PaymentMethods {
  BehaviorSubject _methods = BehaviorSubject.seeded([]);

  Stream get stream$ => _methods.stream;

  dynamic get current => _methods.value;

  fetchMethods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _methods.add([]);
      return;
    }

    dynamic methodsData = await getUserMethods();
    _methods.add(methodsData);
  }
}
