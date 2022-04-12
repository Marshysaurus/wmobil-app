import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/streams/Restaurant.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';
import 'package:wmobil/utils/ScreenArguments.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
GetIt getIt = GetIt.instance;
final restaurant = getIt.get<Restaurant>();
DateFormat format = DateFormat.Hms();

class MovementsCard extends StatelessWidget {
  final String restaurantName;
  final List<dynamic> movements;

  const MovementsCard({Key key, this.restaurantName, this.movements})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onTapOnline(context, route) {
      Navigator.pushNamed(context, route,
          arguments: ScreenArguments(
            restaurantName: restaurantName,
            movements: movements,
          ));
    }

    double totalWithdraw = 0.0;
    double totalDeposits = 0.0;

    for (int i = 0; i < movements.length; i++) {
      if (movements[i]["tipo"] == "1")
        totalWithdraw += double.parse(
            (movements[i]["importe"] as String).replaceAll(',', '.'));
      else if (movements[i]["tipo"] == "2")
        totalDeposits += double.parse(
            (movements[i]["importe"] as String).replaceAll(',', '.'));
    }

    return InkWell(
      onTap: () {
        onTapOnline(context, '/restaurant/detail/movements');
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(3, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Movimientos",
              style: wBlackCardHeader500,
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "Retiros",
                  style: wGreenCardText700,
                ),
                Expanded(
                  child: CustomPaint(painter: DotsPainter()),
                ),
                Text(
                  "\$${currencyFormat.format(totalWithdraw)}",
                  style: wBlackCardNormalText500,
                ),
                Text(
                  "MXN",
                  style: wBlackCardSubtext500,
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "Depósitos",
                  style: wGreenCardText700,
                ),
                Expanded(
                  child: CustomPaint(painter: DotsPainter()),
                ),
                Text(
                  "\$${currencyFormat.format(totalDeposits)}",
                  style: wBlackCardNormalText500,
                ),
                Text(
                  "MXN",
                  style: wBlackCardSubtext500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
