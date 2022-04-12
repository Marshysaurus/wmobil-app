import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class SalesWaiter {
  BehaviorSubject _waiter = BehaviorSubject.seeded(null);

  Stream get stream$ => _waiter.stream;

  dynamic get current => _waiter.value;

  setRestaurant(int id) {
    _waiter.add({"id": id, "loading": true});
  }

  setWaiter(int id, String startDate, String endDate) {
    _waiter.add({
      "id": _waiter.value["id"],
      "waiter_id": id,
      "loading": true,
    });
    fetchHistoricWaiter(startDate, endDate, "CERVEZAS");
  }

  fetchHistoricWaiter(
      String startDate, String endDate, String groupProduct) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _waiter.add({});
      return;
    }

    dynamic restaurantWaiterDeliveriesData =
        await getUserRestaurantHistoricWaiterDeliveries(_waiter.value["id"],
            _waiter.value["waiter_id"], startDate, endDate, groupProduct);

    _waiter.add({
      ...restaurantWaiterDeliveriesData,
      "id": _waiter.value["id"],
      "waiter_id": _waiter.value["waiter_id"],
      "loading": false,
    });
  }
}
