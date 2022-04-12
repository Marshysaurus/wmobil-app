import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

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

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class DetailedProductCard extends StatelessWidget {
  final dynamic product;
  const DetailedProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
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
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Text(
                "Detalle de productos",
                style: wBlackCardHeader500,
              ),
            ),
            Row(
              children: [
                Text(
                  "${product["cantidad"] ?? 0} x ${getCapitalizeString(product["descripcion"] ?? "Producto desconocido")}",
                  style: wGreenCardText700,
                ),
                Expanded(
                  child: CustomPaint(
                    painter: DotsPainter(),
                  ),
                ),
                Text(
                  "\$${currencyFormat.format(double.parse(product["precio"] ?? "0"))}",
                  style: wBlackCardNormalText500,
                ),
                Text(
                  "MXN",
                  style: wBlackCardSubtext500,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Descuento",
                  style: wGreenSubtext700,
                ),
                Spacer(),
                Text(
                  "${currencyFormat.format(double.parse(product["descuento"] ?? "0"))}",
                  style: wBlackCardNormalText500,
                ),
                Text(
                  "%",
                  style: wBlackCardSubtext500,
                ),
              ],
            ),
          ],
        ));
  }
}
