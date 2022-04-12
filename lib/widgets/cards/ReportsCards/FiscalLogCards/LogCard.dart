import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';

final NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

class LogCard extends StatelessWidget {
  final Map<String, dynamic> row;
  LogCard({this.row});

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Tipo:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text(
                    row["tipo"],
                    style: wTextStyle400,
                    overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Fecha:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text(
                    '${row["fecha"]}'
                        .replaceAllMapped('T', (match) => ' ')
                        .replaceAll('.000Z', ''),
                    style: wTextStyle400,
                    overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Inicio:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text(
                    '${row["fechainicial"]}'
                        .replaceAllMapped('T', (match) => ' ')
                        .replaceAll('.000Z', ''),
                    style: wTextStyle400,
                    overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Cierre:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text(
                    '${row["fechafinal"]}'
                        .replaceAllMapped('T', (match) => ' ')
                        .replaceAll('.000Z', ''),
                    style: wTextStyle400,
                    overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Total de cuentas:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text(
                    '${row["cuentastotal"]}',
                    style: wTextStyle400,
                    overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Cuentas modificadas:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text(
                    '${row["cuentasmodificadas"]}',
                    style: wTextStyle400,
                    overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Importe anterior:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text('\$ ${currencyFormat.format(double.parse('${row["importeanterior"]}'.replaceAll(',', '.')))}',
                    style: wTextStyle400, overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Importe nuevo:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text('\$ ${currencyFormat.format(double.parse('${row["importenuevo"]}'.replaceAll(',', '.')))}',
                    style: wTextStyle400, overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Diferencia:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text('\$ ${currencyFormat.format(double.parse('${row["diferencia"]}'.replaceAll(',', '.')))}',
                    style: wTextStyle400, overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
