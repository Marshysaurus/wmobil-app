import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmobil/utils/Tables.dart';

class TableStream {
  BehaviorSubject _table = BehaviorSubject.seeded(null);

  Stream get stream$ => _table.stream;

  dynamic get current => _table.value;

  setTable(int tableID, restaurantID) {
    _table.add(
        {"table_id": tableID, "restaurant_id": restaurantID, "loading": true});
    fetchTable();
  }

  fetchTable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("jwt");

    if (user == null) {
      _table.add({});
      return;
    }

    dynamic tableData =
        await getTable(_table.value["table_id"], _table.value["restaurant_id"]);

    _table.add({
      ...tableData,
      "loading": false,
      "table_id": _table.value["table_id"],
      "restaurant_id": _table.value["restaurant_id"]
    });
  }
}
