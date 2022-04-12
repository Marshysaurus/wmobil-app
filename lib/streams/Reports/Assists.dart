import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class Assists {
  BehaviorSubject _assists = BehaviorSubject.seeded(null);

  Stream get stream$ => _assists.stream;

  dynamic get current => _assists.value;

  setRestaurant(int id) {
    _assists.add({
      "id": id,
      "loading": false,
      "feedback": "Seleccione el rango de fechas"
    });
  }

  refreshRestaurant() {
    _assists.add({
      "id": _assists.value["id"],
      "loading": false,
      "feedback": "Seleccione el rango de fechas"
    });
  }

  fetchAssists(String startDate, String endDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _assists.add({});
      return;
    }

    if (startDate == " " || endDate == " ") {
      _assists.add({
        "id": _assists.value["id"],
        "loading": false,
        "feedback": "No seleccionaste ninguna fecha..."
      });
      return;
    }

    _assists.add({
      "id": _assists.value["id"],
      "loading": false,
      "feedback": "Cargando solicitud..."
    });

    dynamic restaurantAssists =
    await getUserRestaurantAssists(
        _assists.value["id"], startDate, endDate);

    _assists.add({
      ...restaurantAssists,
      "id": _assists.value["id"],
      "loading": false,
      "feedback": "Solicitud completada"
    });
  }
}
