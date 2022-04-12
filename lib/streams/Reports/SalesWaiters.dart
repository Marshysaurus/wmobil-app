import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class SalesWaiters {
  BehaviorSubject _waiters = BehaviorSubject.seeded(null);

  Stream get stream$ => _waiters.stream;

  dynamic get current => _waiters.value;

  setRestaurant(int id) {
    _waiters.add({"id": id, "loading": true});
  }

  fetchHistoricWaiters(String startDate, String endDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _waiters.add({});
      return;
    }

    dynamic restaurantWaitersData = await getUserRestaurantHistoricWaiters(
        _waiters.value["id"], startDate, endDate);

    _waiters.add({...restaurantWaitersData, "loading": false, "id" : _waiters.value["id"]});
  }
}
