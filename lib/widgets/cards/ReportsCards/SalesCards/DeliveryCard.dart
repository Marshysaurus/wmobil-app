import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';

class DeliveryCard extends StatelessWidget {
  final Map<String, dynamic> delivery;
  DeliveryCard({this.delivery});

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
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Container(
                  child: Text("Producto:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(child: Text('${delivery["descripcion"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Container(
                  child: Text("Costo:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(child: Text('${delivery["precio"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Container(
                  child: Text("Cantidad:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(child: Text('${delivery["cantidad"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Container(
                  child: Text("Total:", style: wTextStyle500),
                  margin: EdgeInsets.only(right: 5),
                ),
                Flexible(child: Text('${delivery["total"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ],
        ));
  }
}
