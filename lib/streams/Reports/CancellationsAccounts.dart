import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class CancellationsAccounts {
  BehaviorSubject _accounts = BehaviorSubject.seeded(null);

  Stream get stream$ => _accounts.stream;

  dynamic get current => _accounts.value;

  setRestaurant(int id) {
    _accounts.add({
      "id": id,
      "loading": false,
      "feedback": "Seleccione el rango de fechas"
    });
  }

  refreshRestaurant() {
    _accounts.add({
      "id": _accounts.value["id"],
      "loading": false,
      "feedback": "Seleccione el rango de fechas"
    });
  }

  fetchCancellationAccounts(String startDate, String endDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _accounts.add({});
      return;
    }

    if (startDate == " " || endDate == " ") {
      _accounts.add({
        "id": _accounts.value["id"],
        "loading": false,
        "feedback": "No seleccionaste ninguna fecha..."
      });
      return;
    }

    _accounts.add({
      "id": _accounts.value["id"],
      "loading": true,
      "feedback": "Cargando solicitud..."
    });

    dynamic cancellationAccountsData =
        await getUserRestaurantAccountsCancellations(
            _accounts.value["id"], startDate, endDate);

    _accounts.add({
      ...cancellationAccountsData,
      "loading": false,
      "id": _accounts.value["id"],
      "feedback": "Solicitud completada"
    });
  }
}
