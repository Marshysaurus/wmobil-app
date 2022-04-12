import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class SalesMovements {
  BehaviorSubject _movements = BehaviorSubject.seeded(null);

  Stream get stream$ => _movements.stream;

  dynamic get current => _movements.value;

  setRestaurant(int id) {
    _movements.add({"id": id, "loading": false, "feedback": "Seleccione el rango de fechas"});
  }

  refreshRestaurant() {
    _movements.add({"id": _movements.value["id"], "loading": false, "feedback": "Seleccione el rango de fechas"});
  }

  fetchHistoricMovements(String startDate, String endDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _movements.add({});
      return;
    }

    if (startDate == " " || endDate == " ") {
      _movements.add({"id": _movements.value["id"], "loading": false, "feedback": "No seleccionaste ninguna fecha..."});
      return;
    }

    _movements.add({"id": _movements.value["id"], "loading": true, "feedback": "Cargando solicitud..."});

    dynamic restaurantMovementsData = await getUserRestaurantHistoricMovements(
        _movements.value["id"], startDate, endDate);

    _movements.add({...restaurantMovementsData, "loading": false, "id" : _movements.value["id"], "feedback": "Solicitud completada"});
  }
}
