import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

class AccountCard extends StatelessWidget {
  final Map<String, dynamic> account;
  AccountCard({this.account});

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
            children: <Widget>[
              Text("Fecha:", style: wGreenCardText700,),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                  '${account["fecha"]}'
                      .replaceAllMapped('T', (match) => ' ')
                      .replaceAll('.000Z', ''),
                  style: wBlackCardNormalText500,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            children: <Widget>[
              Text("Folio", style: wGreenCardText700,),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text('${account["folio"]}',
                  style: wBlackCardNormalText500, overflow: TextOverflow.ellipsis,),
            ],
          ),
          Row(
            children: <Widget>[
              Text("Importe", style: wGreenCardText700,),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text('\$${currencyFormat.format(double.parse('${account["importe"]}'))}',
                  style: wBlackCardNormalText500, overflow: TextOverflow.ellipsis,),
              Text(
                'MXN',
                style: wBlackCardSubtext500,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("Descuento", style: wGreenCardText700),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text('\$${currencyFormat.format(double.parse('${account["importe_descuento"]}'))}',
                  style: wBlackCardNormalText500, overflow: TextOverflow.ellipsis,),
              Text(
                'MXN',
                style: wBlackCardSubtext500,
              )
            ],
          ),
        ],
      ),
    );
  }
}
