import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class FiscalLog {
  BehaviorSubject _log = BehaviorSubject.seeded(null);

  Stream get stream$ => _log.stream;

  dynamic get current => _log.value;

  setRestaurant(int id) {
    _log.add({
      "id": id,
      "canGetBitacoraFiscal": false,
      "loading": false,
      "feedback": "Seleccione el rango de fechas"
    });
    fetchFiscalLogPermission();
  }

  refreshRestaurant() {
    _log.add({
      "id": _log.value["id"],
      "canGetBitacoraFiscal": _log.value["canGetBitacoraFiscal"],
      "loading": false,
      "feedback": "Seleccione el rango de fechas"
    });
  }

  fetchFiscalLogPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _log.add({});
      return;
    }

    _log.add({
      "id": _log.value["id"],
      "canGetBitacoraFiscal": _log.value["canGetBitacoraFiscal"],
      "loading": true,
      "feedback": "Cargando solicitud..."
    });

    dynamic restaurantFiscalLog =
        await getUserRestaurantFiscalLogPermission(_log.value["id"]);

    _log.add({
      ...restaurantFiscalLog,
      "id": _log.value["id"],
      "loading": _log.value["loading"],
      "feedback": _log.value["feedback"]
    });

    if (_log.value["canGetBitacoraFiscal"])
      fetchFiscalLog();
  }

  fetchFiscalLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _log.add({});
      return;
    }

    _log.add({
      "id": _log.value["id"],
      "canGetBitacoraFiscal": _log.value["canGetBitacoraFiscal"],
      "loading": false,
      "feedback": "Cargando solicitud..."
    });

    dynamic restaurantFiscalLog =
        await getUserRestaurantFiscalLog(_log.value["id"]);

    _log.add({
      ...restaurantFiscalLog,
      "id": _log.value["id"],
      "canGetBitacoraFiscal": _log.value["canGetBitacoraFiscal"],
      "loading": false,
      "feedback": "Solicitud completada"
    });
  }
}
