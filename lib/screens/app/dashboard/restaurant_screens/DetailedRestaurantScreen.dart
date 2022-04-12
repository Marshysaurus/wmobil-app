import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wmobil/models/Restaurant.dart';
import 'package:wmobil/streams/Restaurant.dart';
import 'package:wmobil/widgets/cards/DiscountsAndCancellationsCard.dart';
import 'package:wmobil/widgets/cards/EarningsCard.dart';
import 'package:wmobil/widgets/cards/MovementsCard.dart';
import 'package:wmobil/widgets/cards/PaymentMethodsCard.dart';
import 'package:wmobil/widgets/cards/ProductsCard.dart';
import 'package:wmobil/widgets/cards/RestaurantStatsCard.dart';
import 'package:wmobil/widgets/cards/TurnsCard.dart';

GetIt getIt = GetIt.instance;

class DetailedRestaurantScreen extends StatelessWidget {
  final restaurant = getIt.get<Restaurant>();

  DetailedRestaurantScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: new IconButton(
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
          title: Text("Detalles Restaurante (Online)",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: -.02,
                  color: Color.fromRGBO(33, 33, 33, 1))),
        ),
        body: StreamBuilder<Object>(
            stream: restaurant.stream$,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null || snapshot.data["loading"]) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(53, 175, 46, 1)),
                  ),
                );
              }

              RestaurantModel restaurantModel =
                  RestaurantModel.fromJSON(snapshot.data);

              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      EarningsCard(
                        restaurantModel: restaurantModel,
                      ),
                      PaymentMethodsCard(
                        paymentMethod: restaurantModel.paymentMethods,
                      ),
                      ProductsCard(
                        drinkRevenue: restaurantModel.drinkRevenue,
                        foodRevenue: restaurantModel.foodRevenue,
                      ),
                      MovementsCard(
                        restaurantName: 'Regresar a restaurante',
                        movements: restaurantModel.movements,
                      ),
                      TurnsCard(
                        turns: restaurantModel.turns,
                      ),
                      DiscountsAndCancellationsCard(
                        discounts: restaurantModel.discounts,
                        productCancellations: restaurantModel.cancellations,
                        tableCancellations: restaurantModel.cancelledAccounts,
                        discountsPerProduct: restaurantModel.discountsPerProduct,
                        discountsPerAccount: restaurantModel.discountsPerAccount,
                        cancellationsPerAccount: restaurantModel.cancellationsPerAccount,
                        cancellationsPerProduct: restaurantModel.cancellationsPerProduct,
                      ),
                      RestaurantStatsCard(
                        lastMonth: restaurantModel.lastMonthTotal,
                        lastWeek: restaurantModel.lastWeekTotal,
                        lastYear: restaurantModel.lastYearTotal,
                        prediction: restaurantModel.prediction,
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
