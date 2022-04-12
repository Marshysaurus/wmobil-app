import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/streams/Restaurant.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
GetIt getIt = GetIt.instance;
final restaurant = getIt.get<Restaurant>();
DateFormat format = DateFormat.Hms();

class TurnsCard extends StatelessWidget {
  final List<dynamic> turns;

  const TurnsCard({Key key, this.turns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
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
                "Ventas por turno",
                style: wBlackCardHeader500,
              ),
              SizedBox(height: 5),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: turns.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Text(
                          "Turno ${turns[index]["index"]}",
                          style: wGreenCardText700,
                        ),
                        Expanded(
                          child: CustomPaint(
                            painter: DotsPainter(),
                          ),
                        ),
                        Text(
                          "\$${currencyFormat.format(double.parse("${turns[index]["total"]}"))}",
                          style: wBlackCardNormalText500,
                        ),
                        Text(
                          "MXN",
                          style: wBlackCardSubtext500,
                        ),
                      ],
                    );
                  }),
            ]));
  }
}
