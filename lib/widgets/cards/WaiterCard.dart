import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';
import 'package:wmobil/utils/Icons/w_custom_icons_icons.dart';

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

class WaiterCard extends StatelessWidget {
  final dynamic waiter;
  final int index;

  const WaiterCard({Key key, this.waiter, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(getCapitalizeString(waiter["nombre"]),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                          letterSpacing: -.02,
                          color: Color.fromRGBO(33, 33, 33, 1)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                waiter["ranking"] <= 3
                    ? Container(
                  width: 30,
                  height: 30,
                  child: Center(
                      child: Image(
                        image: AssetImage(
                            'assets/medals/${waiter["ranking"]}Place.png'),
                      )),
                )
                    : Container()
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                Text(
                  "Total",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      letterSpacing: -.02,
                      color: Color.fromRGBO(33, 33, 33, 1)),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: DotsPainter(),
                  ),
                ),
                Text(
                    '\$${currencyFormat.format(double.parse("${waiter["total"]}"))}',
                    style: wNumberStyle700.copyWith(fontSize: 18.0)),
                Text("MXN",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        letterSpacing: -.02,
                        color: Color.fromRGBO(33, 33, 33, 1))),
              ],
            ),
            Row(
              children: [
                Text(
                  "Propinas",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      letterSpacing: -.02,
                      color: Color.fromRGBO(33, 33, 33, 1)),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: DotsPainter(),
                  ),
                ),
                Text(
                  '\$${currencyFormat
                      .format(double.parse("${waiter["tips"]}"))}',
                  style: wNumberStyle700.copyWith(fontSize: 18.0),
                ),
                Text("MXN",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        letterSpacing: -.02,
                        color: Color.fromRGBO(33, 33, 33, 1))),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${waiter["tables"]}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Icon(WCustomIcons.table),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${waiter["items"]}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.fastfood),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${waiter["people"]}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.people),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
