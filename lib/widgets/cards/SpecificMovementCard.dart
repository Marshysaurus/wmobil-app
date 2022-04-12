import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat("yyyy-MM-dd h:mm aaa");

class SpecificMovementCard extends StatelessWidget {
  final LinkedHashMap<String, dynamic> movement;
  final int ranking;

  const SpecificMovementCard({this.movement, this.ranking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          Text("Turno $ranking", style: wBlackCardHeader500),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Fecha",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                format
                    .format(DateTime.parse(movement["fecha"].substring(0, 19))),
                style: wBlackCardNormalText500,
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Tipo de movimiento",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                movement["tipo"] == "1" ? "Retiro" : "Depósito",
                style: wBlackCardNormalText500,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Importe",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$ ${currencyFormat.format(double.parse(movement["importe"]))}",
                style: wBlackCardNormalText500,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Concepto",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                movement["concepto"] != ""
                    ? movement["concepto"]
                    : "SIN DESCRIPCIÓN",
                style: wBlackCardNormalText500,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Referencia",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                movement["referencia"] != ""
                    ? movement["concepto"]
                    : "SIN DESCRIPCIÓN",
                style: wBlackCardNormalText500,
              ),
            ],
          )
        ],
      ),
    );
  }
}
