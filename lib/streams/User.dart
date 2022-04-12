import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Auth.dart';

class User {
  BehaviorSubject _user = BehaviorSubject.seeded(null);

  Stream get stream$ => _user.stream;

  dynamic get current => _user.value;

  fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _user.add(user);
      return;
    }

    dynamic userData = await getUserData();
    _user.add(userData);
  }

  disconnectUser() async {
    _user.add(null);
    return;
  }
}
