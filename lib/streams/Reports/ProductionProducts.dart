import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Restaurants.dart';

class ProductionProducts {
  BehaviorSubject _products = BehaviorSubject.seeded(null);

  Stream get stream$ => _products.stream;

  dynamic get current => _products.value;

  setRestaurant(int id) {
    _products.add({
      "id": id,
      "loading": false,
      "feedback": "Seleccione el rango de fechas"
    });
  }

  refreshRestaurant() {
    _products.add({
      "id": _products.value["id"],
      "loading": false,
      "feedback": "Seleccione el rango de fechas"
    });
  }

  fetchProductionProducts(String startDate, String endDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _products.add({});
      return;
    }

    if (startDate == " " || endDate == " ") {
      _products.add({
        "id": _products.value["id"],
        "loading": false,
        "feedback": "No seleccionaste ninguna fecha..."
      });
      return;
    }

    _products.add({
      "id": _products.value["id"],
      "loading": false,
      "feedback": "Cargando solicitud..."
    });

    dynamic restaurantProductionProducts =
        await getUserRestaurantProductsInProduction(
            _products.value["id"], startDate, endDate);

    _products.add({
      ...restaurantProductionProducts,
      "id": _products.value["id"],
      "loading": false,
      "feedback": "Solicitud completada"
    });
  }
}
