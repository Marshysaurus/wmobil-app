import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';

class MovementCard extends StatelessWidget {
  final Map<String, dynamic> movement;
  MovementCard({this.movement});

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
                    2.0,
                    4.0,
                  ))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text("Fecha:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(
                  child: Text('${movement["fecha"]}'.replaceAllMapped('T', (match) => ' ').replaceAll('.000Z', ''), style: wTextStyle400, overflow: TextOverflow.ellipsis)
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text("Tipo:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(
                  child: Text('${movement["tipo"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text("Concepto:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(
                  child: Text('${movement["concepto"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text("Referencia:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(
                  child:
                      Text('${movement["referencia"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text("Importe:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(
                  child: Text('${movement["importe"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)
                ),
              ],
            ),
          ],
        ));
  }
}
