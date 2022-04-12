import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class RestaurantStatsCard extends StatelessWidget {
  final double prediction;
  final double lastWeek;
  final double lastMonth;
  final double lastYear;

  const RestaurantStatsCard({
    Key key,
    this.prediction,
    this.lastWeek,
    this.lastMonth,
    this.lastYear,
  }) : super(key: key);

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
            "ESTADÍSTICAS DE INGRESOS",
            style: wBlackCardHeader500,
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text("Semana pasada", style: wGreenCardText700),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(lastWeek)}",
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
                "Mes pasado",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(lastMonth)}",
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
                "Año pasado",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(lastYear)}",
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
                "Predicción",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(prediction)}",
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
    );
  }
}
