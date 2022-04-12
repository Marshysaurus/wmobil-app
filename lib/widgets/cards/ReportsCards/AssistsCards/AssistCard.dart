import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

class AssistCard extends StatelessWidget {
  final Map<String, dynamic> row;
  AssistCard({this.row});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, .18),
                blurRadius: 5.0, // has the effect of softening the shadow
                spreadRadius: 2.0, // has the effect of extending the shadow
                offset: Offset(
                  2.0, // horizontal, move right 10
                  4.0, // vertical, move down 10
                ))
          ]),
      child: Column(
        children: <Widget>[
          Text(
            '${row["empleado"]}',
            style: wTextStyle400,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: <Widget>[
              Text("Entrada", style: wTextStyle500),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Text(
                '${row["entrada"]}'
                    .replaceAllMapped('T', (match) => ' ')
                    .replaceAll('.000Z', ''),
                style: wTextStyle400,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text("Salida", style: wTextStyle500),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Text(
                '${row["salida"]}'
                    .replaceAllMapped('T', (match) => ' ')
                    .replaceAll('.000Z', ''),
                style: wTextStyle400,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
