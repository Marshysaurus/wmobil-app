import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';

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
                child: Text("Folio:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text('${product["folio"]}',
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
                child: Text("Producto:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Flexible(
                child: Container(
                  child: Text('${product["producto"]}',
                      style: wTextStyle400, overflow: TextOverflow.ellipsis),
                  margin: EdgeInsets.only(right: 5),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Cantidad:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                child: Text('${product["cantidad"]}',
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
                child: Text("Fecha:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Container(
                child: Text("Mesero:", style: wTextStyle500),
                margin: EdgeInsets.only(right: 5),
              ),
              Flexible(
                child: Container(
                  child: Text('${product["mesero"]["nombre"]}',
                      style: wTextStyle400, overflow: TextOverflow.ellipsis),
                  margin: EdgeInsets.only(right: 5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
