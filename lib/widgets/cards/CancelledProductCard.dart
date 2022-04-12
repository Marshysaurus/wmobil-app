import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");

String getCapitalizeString(String str) {
  if (str == null) return "";

  if (str.length <= 1) return str.toUpperCase();

  List<String> stringArray = str.split(" ");
  List<String> newStringArray = [];
  stringArray.forEach((element) {
    if (element.length <= 1) {
      newStringArray.add(element.toUpperCase());
      return;
    }

    newStringArray.add(
        '${element[0].toUpperCase()}${element.substring(1).toLowerCase()}');
  });

  return newStringArray.join(" ");
}

class CancelledProductCard extends StatelessWidget {
  final dynamic product;

  const CancelledProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        padding: EdgeInsets.all(16),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(3, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: <Widget>[
                              Container(
                                child: Text("\$",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                        letterSpacing: -.02,
                                        color: Color.fromRGBO(33, 33, 33, 1))),
                                margin: EdgeInsets.only(right: 5),
                              ),
                              Container(
                                child: Text(
                                    currencyFormat.format(
                                        double.parse("${product["precio"]}")),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        letterSpacing: -.02,
                                        color: Color.fromRGBO(53, 175, 46, 1))),
                                margin: EdgeInsets.only(right: 5),
                              ),
                              Text("MXN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      letterSpacing: -.02,
                                      color: Color.fromRGBO(33, 33, 33, 1))),
                            ],
                          ),
                        ]),
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 05, 0, 0),
                      child: Text("${getCapitalizeString(product["producto"])}",
                          textAlign: TextAlign.left, style: wTextStyle400)),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 05, 0, 0),
                      child: Text(
                          "Razón: ${getCapitalizeString(product["razon"])}",
                          textAlign: TextAlign.left,
                          style: wTextStyle400)),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 05, 0, 0),
                      child: Text(
                          "${getCapitalizeString("${product["cantidad"]}")} unidades",
                          textAlign: TextAlign.left,
                          style: wTextStyle300)),
                ],
              ),
            ),
          ],
        ));
  }
}
