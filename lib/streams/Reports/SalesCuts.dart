import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class SalesCuts {
  BehaviorSubject _cuts = BehaviorSubject.seeded(null);

  Stream get stream$ => _cuts.stream;

  dynamic get current => _cuts.value;

  setRestaurant(int id) {
    _cuts.add({"id": id, "loading": false, "feedback": "Seleccione el rango de fechas"});
  }

  refreshRestaurant() {
    _cuts.add({"id": _cuts.value["id"], "loading": false, "feedback": "Seleccione el rango de fechas"});
  }

  fetchHistoricCuts(String startDate, String endDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _cuts.add({});
      return;
    }

    if (startDate == " " || endDate == " ") {
      _cuts.add({"id": _cuts.value["id"], "loading": false, "feedback": "No seleccionaste ninguna fecha..."});
      return;
    }

    _cuts.add({"id": _cuts.value["id"], "loading": true, "feedback": "Cargando solicitud..."});

    dynamic restaurantCutsData = await getUserRestaurantHistoricCuts(
        _cuts.value["id"], startDate, endDate);

    _cuts.add({...restaurantCutsData, "loading": false, "id" : _cuts.value["id"], "feedback": "Solicitud completada"});
  }
}
