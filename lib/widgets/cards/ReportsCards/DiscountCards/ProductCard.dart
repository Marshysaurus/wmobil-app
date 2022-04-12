import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = NumberFormat("#,##0.00", "en_US");

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  ProductCard({this.product});

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
                child: Text(
                  "Fecha:",
                  style: wGreenCardText700,
                ),
                margin: EdgeInsets.only(right: 5),
              ),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Container(
                child: Text(
                    '${product["fecha"]}'
                        .replaceAllMapped('T', (match) => ' ')
                        .replaceAll('.000Z', ''),
                    style: wTextStyle400,
                    overflow: TextOverflow.ellipsis),
                margin: EdgeInsets.only(right: 5),
              ),
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     Text(
          //       "Folio",
          //       style: wGreenCardText700,
          //     ),
          //     Expanded(
          //       child: CustomPaint(painter: DotsPainter()),
          //     ),
          //     Text('${product["folio"]}',
          //         style: wTextStyle400, overflow: TextOverflow.ellipsis),
          //   ],
          // ),
          Row(
            children: <Widget>[
              Text(
                "Producto:",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Text('${product["producto"]["nombre"]}',
                  style: wTextStyle400, overflow: TextOverflow.ellipsis),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Grupo",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Text('${product["producto"]["grupo"]}',
                  style: wTextStyle400, overflow: TextOverflow.ellipsis),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Cantidad",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Text('${product["cantidad"]}',
                  style: wTextStyle400, overflow: TextOverflow.ellipsis),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Precio",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Text(
                  '\$${currencyFormat.format(double.parse('${product["precio"]}'))}',
                  style: wTextStyle400,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Descuento:",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Text(
                  '\$${currencyFormat.format(double.parse('${product["importe_descuento"]}'))}',
                  style: wTextStyle400,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
    );
  }
}
