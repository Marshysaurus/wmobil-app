import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

class CutCard extends StatelessWidget {
  final Map<String, dynamic> cut;
  CutCard({this.cut});

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
                Text(
                  "Apertura",
                  style: wGreenCardText700,
                ),
                Expanded(
                  child: CustomPaint(painter: DotsPainter()),
                ),
                Text(
                    '${cut["apertura"]}'
                        .replaceAllMapped('T', (match) => ' ')
                        .replaceAll('.000Z', ''),
                    style: wBlackCardNormalText500,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Cierre",
                  style: wGreenCardText700,
                ),
                Expanded(
                  child: CustomPaint(painter: DotsPainter()),
                ),
                Text(
                    '${cut["cierre"]}'
                        .replaceAllMapped('T', (match) => ' ')
                        .replaceAll('.000Z', ''),
                    style: wBlackCardNormalText500,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Total",
                  style: wGreenCardText700,
                ),
                Expanded(
                  child: CustomPaint(painter: DotsPainter()),
                ),
                Text(
                  '\$${(cut["total"] as num).toStringAsFixed(2)}',
                  style: wBlackCardNormalText500,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'MXN',
                  style: wBlackCardSubtext500,
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Subtotal",
                  style: wGreenCardText700,
                ),
                Expanded(
                  child: CustomPaint(painter: DotsPainter()),
                ),
                Text(
                  '\$${(cut["subTotal"] as num).toStringAsFixed(2)}',
                  style: wBlackCardNormalText500,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'MXN',
                  style: wBlackCardSubtext500,
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Efectivo",
                  style: wGreenCardText700,
                ),
                Expanded(
                  child: CustomPaint(painter: DotsPainter()),
                ),
                Text(
                  '\$${(cut["efectivo"] as num).toStringAsFixed(2)}',
                  style: wBlackCardNormalText500,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'MXN',
                  style: wBlackCardSubtext500,
                )
              ],
            ),
          ],
        ));
  }
}
