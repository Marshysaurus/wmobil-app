import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class Restaurants {
  BehaviorSubject _restaurants = BehaviorSubject.seeded(null);

  Stream get stream$ => _restaurants.stream;

  fetchRestaurants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _restaurants.add(user);
      return;
    }

    dynamic restaurantData = await getUserRestaurants();

    _restaurants.add(restaurantData);
  }
}
