import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class Restaurant {
  BehaviorSubject _restaurant = BehaviorSubject.seeded(null);

  Stream get stream$ => _restaurant.stream;

  dynamic get current => _restaurant.value;

  setRestaurant(int id) {
    _restaurant.add({"id": id, "loading": true});
    fetchRestaurant();
  }

  fetchRestaurant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _restaurant.add({});
      return;
    }

    dynamic restaurantData = await getUserRestaurant(_restaurant.value["id"]);

    _restaurant.add({...restaurantData, "loading": false});
  }

  removeRestaurant() {
    _restaurant.value = null;
  }
}
