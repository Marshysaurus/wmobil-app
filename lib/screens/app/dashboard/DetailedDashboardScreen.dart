import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wmobil/streams/Restaurants.dart';
import 'package:wmobil/widgets/cards/DiscountsAndCancellationsCard.dart';
import 'package:wmobil/widgets/cards/EarningsCard.dart';
import 'package:wmobil/widgets/cards/PaymentsCard.dart';
import 'package:wmobil/widgets/cards/ProductsCard.dart';
import 'package:wmobil/widgets/cards/RestaurantStatsCard.dart';

GetIt getIt = GetIt.instance;

class DetailedDashboardScreen extends StatelessWidget {
  final restaurants = getIt.get<Restaurants>();

  DetailedDashboardScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: restaurants.stream$,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.data == null || snap.data["overview"] == null) {
            return Container();
          }

          dynamic overview = snap.data["overview"];

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: IconButton(
                  hoverColor: Colors.black,
                  iconSize: 16,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text("Todos (Online)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: -.02,
                        color: Color.fromRGBO(33, 33, 33, 1))),
              ),
              body: SingleChildScrollView(
                  child: Container(
                      child: Column(children: <Widget>[
                EarningsCard(
                  cancellations: overview["cancellations"],
                  items: overview["cancellations"],
                  number: double.parse("${overview["total"]}"),
                  lastFetched:
                      DateTime.parse(overview["last_fetched"]).toLocal(),
                  people: overview["people"],
                  tablesOpen: overview["openTables"],
                ),
                PaymentsCard(
                  card: double.parse("${overview["card"]}"),
                  cash: double.parse("${overview["cash"]}"),
                  payed: double.parse("${overview["payed"]}"),
                ),
                ProductsCard(
                  drinkRevenue: double.parse("${overview["drinks"]}"),
                  foodRevenue: double.parse("${overview["food"]}"),
                ),
                RestaurantStatsCard(
                  lastMonth: double.parse("${overview["lastMonth"]}"),
                  lastWeek: double.parse("${overview["lastWeek"]}"),
                  lastYear: double.parse("${overview["lastYear"]}"),
                  prediction: double.parse("${overview["prediction"]}"),
                ),
                DiscountsAndCancellationsCard(
                  discounts: double.parse("${overview["descuentos"]}"),
//                  discountsInDrinks: 35.0,
//                  discountsInFood: 165.0,
                  productCancellations:
                      int.parse("${overview["cancelaciones"]}"),
                  tableCancellations:
                      double.parse("${overview["cuentascanceladas"]}"),
                )
              ]))));
        });
  }
}
